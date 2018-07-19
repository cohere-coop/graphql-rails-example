require('dotenv').config()

const { createHttpLink } = require('apollo-link-http')
const { ApolloClient } = require('apollo-client')
const { InMemoryCache } = require('apollo-cache-inmemory')
const fetch = require('node-fetch')
const { setWorldConstructor } = require('cucumber')
const Mustache = require('mustache')

const gql = require('graphql-tag')

class World {
  constructor () {
    this.data = {}
    const cache = new InMemoryCache()
    const link = createHttpLink({ uri: `${process.env.API_ENDPOINT}/graphql`, fetch })
    this.client = new ApolloClient({ link, cache })
  }

  mutate (mutation) {
    return this.client.mutate({ mutation: gql(mutation) })
  }

  interpolate (string) {
    return Mustache.render(string, this.data)
  }

  set variables (variables) {
    this._variables = variables
  }

  get variables () {
    return JSON.parse(this.interpolate(this.variables))
  }
}

setWorldConstructor(World)
