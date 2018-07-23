require('dotenv').config()
const { AppClient } = require('./app-client')

const { setWorldConstructor } = require('cucumber')
const Mustache = require('mustache')
const { at, last } = require('lodash')

const gql = require('graphql-tag')

class World {
  constructor () {
    this.data = {}
    this.client = new AppClient({})
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
