require('dotenv').config()

const { setWorldConstructor } = require('cucumber')
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
    return { email: `user-${cuid()}@example.com`, password: 'password', taskLists: [] }
  }

  registerMe () {
    this.data.me = this.randomPerson()
    const { email, password } = this.data.me
    return this.client.register({ identity: { emailAndPassword: { email, password } } }).then(({ data }) => {
      this.data.me.id = data.register.user.id
      return { data }
    })
  }

  mutate (mutation) {
    return this.client.mutate({ mutation: gql(mutation), variables: this.variables }).then((result) => {
      this.responses.push(result)
    })
  }

  interpolate (string) {
    return Mustache.render(string, this.data)
  }

  query (query) {
    return this.client.query({ query: gql(query), variables: this.variables })
  }

  lookup (loc) {
    return at(this.response.data, loc)[0]
  }

  get response () {
    return last(this.responses)
  }

  get responses () {
    this._responses = this._responses || []
    return this._responses
  }

  set variables (variables) {
    this._variables = variables
  }

  get variables () {
    return JSON.parse(this.interpolate(this._variables))
  }
}

setWorldConstructor(World)
