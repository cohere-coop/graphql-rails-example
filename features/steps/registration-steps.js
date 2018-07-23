const { Given, Then } = require('cucumber')
const cuid = require('cuid')
const { AppClient } = require('../support/app-client')
const gql = require('graphql-tag')
const chai = require('chai')
const chaiAsPromised = require('chai-as-promised')

const { expect } = chai

chai.use(chaiAsPromised)

Given('I have not yet registered', function () {
  this.data.me = { email: `user-${cuid()}@example.com`, password: 'password' }
})

Given('I have already registered', function () {
  this.data.me = { email: `user-${cuid()}@example.com`, password: 'password' }
  return this.client.register({ identity: { emailAndPassword: this.data.me } }).then(({ data }) => {
    this.data.me.id = data.register.user.id
  })
})

Then('the response has a functioning access token at {string}', function (loc) {
  const client = new AppClient({ token: this.lookup(loc) })

  return client.query({ query: gql`query Me { me { id } }` })
})

Then('the response does not have a functioning access token at {string}', function (loc) {
  const client = new AppClient({ token: this.lookup(loc) })

  return expect(client.query({ query: gql`query Me { me { id } }` }).then(({ data }) => data.me.id)).to.eventually.be.null
})
