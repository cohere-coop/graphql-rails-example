const { Given, Then } = require('cucumber')
const { AppClient } = require('../support/app-client')
const gql = require('graphql-tag')
const chai = require('chai')
const chaiAsPromised = require('chai-as-promised')

const { expect } = chai
const { merge, last, times } = require('lodash')

chai.use(chaiAsPromised)

Given('I have not yet registered', function () {
  this.data.me = this.randomPerson()
})

Given('I have already registered', function () {
  return this.registerMe()
})

Given('another user exists', function () {
  const other = this.randomPerson()
  this.users.push(other)
  const { email, password } = other
  return this.client.register({ identity: { emailAndPassword: { email, password } } }).then(({ data }) => {
    merge(other, data.register.user)
  })
})
Given('I have a task list', function () {
  return this.client.createTaskList({ name: 'groceries' })
    .then(({ data }) => this.data.me.taskLists.push(data.taskListCreate.taskList))
})

Given('I have {int} tasks assigned to that task list', function (count) {
  return Promise.all(times(count, (n) => {
    const task = { title: `task ${n}` }
    const taskLists = [last(this.data.me.taskLists).id]
    return this.client.createTask({ task, taskLists }).then(({ data }) => {
      return this.data.me.tasks.push(data.tasksCreate.task)
    })
  }))
})

Given('I am making requests as an authenticated member', function () {
  return this.registerMe().then(({ data }) => {
    this.client = new AppClient({ token: data.register.accessToken })
  })
})

Then('the response has a functioning access token at {string}', function (loc) {
  const client = new AppClient({ token: this.lookup(loc) })

  return client.query({ query: gql`query Me { me { id } }` })
})

Then('the response does not have a functioning access token at {string}', function (loc) {
  const client = new AppClient({ token: this.lookup(loc) })

  return expect(client.query({ query: gql`query Me { me { id } }` }).then(({ data }) => data.me)).to.eventually.be.null
})

Then('I can authenticate with my email and password via the authenticate mutation', function () {
  const identity = { emailAndPassword: { email: this.data.me.email, password: this.data.me.password } }
  return expect(this.client.authenticate({ identity }).then(({ data }) => data.authenticate.access_token))
    .to.eventually.not.be.null
})
