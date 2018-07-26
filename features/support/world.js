require('dotenv').config()

const { After, setWorldConstructor } = require('cucumber')
const cuid = require('cuid')
const Mustache = require('mustache')
const { at, last } = require('lodash')
const gql = require('graphql-tag')

const { AppClient } = require('./app-client')

class World {
  constructor () {
    this.data = {}
    this.client = new AppClient({})
  }

  randomPerson () {
    return { email: `user-${cuid()}@example.com`, password: 'password', taskLists: [], tasks: [] }
  }

  registerMe () {
    this.data.me = this.randomPerson()
    const { email, password } = this.data.me
    return this.client.register({ identity: { emailAndPassword: { email, password } } }).then(({ data }) => {
      this.data.me.id = data.register.user.id
      this.users.push(this.data.me)
      return { data }
    })
  }

  mutate (mutation) {
    return this.client.mutate({ mutation: gql(mutation), variables: this.variables }).then((result) => {
      this.responses.push(result)
    })
  }

  subscribe (query) {
    const subscription = new Promise((resolve, reject) => {
      console.log('defining a subscription')
      this.client.subscribe({ query: gql(query), variables: this.variables }).subscribe({
        next (x) { console.log('got a thing', x); resolve(x) },
        error (err) { console.log('error', err); reject(err) },
        complete () { console.log('complete'); resolve() }
      })
    })
    this.subscriptions.push(subscription)
  }

  interpolate (string) {
    return Mustache.render(string, this.data)
  }

  query (query) {
    return this.client.query({ query: gql(query), variables: this.variables }).then((result) => {
      this.responses.push(result)
    })
  }

  lookup (loc, data) {
    data = data || this.response.data
    return at(data, loc)[0]
  }

  get response () {
    return last(this.responses)
  }

  get users () {
    this.data.users = this.data.users || []
    return this.data.users
  }

  get responses () {
    this._responses = this._responses || []
    return this._responses
  }

  get subscriptions () {
    this._subscriptions = this._subscriptions || []
    return this._subscriptions
  }

  set variables (variables) {
    this._variables = JSON.parse(this.interpolate(variables))
  }

  get variables () {
    return this._variables
  }
}

setWorldConstructor(World)

After(function () {
  this.client.cable.disconnect()
})
