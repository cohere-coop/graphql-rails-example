const { createHttpLink } = require('apollo-link-http')
const { ApolloLink } = require('apollo-link')
const { ApolloClient } = require('apollo-client')
const { InMemoryCache } = require('apollo-cache-inmemory')
const fetch = require('node-fetch')
const gql = require('graphql-tag')

exports.AppClient = class AppClient {
  constructor (options = {}) {
    const { token } = options

    const cache = new InMemoryCache()
    const httpLink = createHttpLink({ uri: `${process.env.API_ENDPOINT}/graphql`, fetch })

    const middlewareLink = new ApolloLink((operation, forward) => {
      if (token) {
        operation.setContext({
          headers: { authorization: `Bearer ${token}` }
        })
      }
      return forward(operation)
    })
    const link = middlewareLink.concat(httpLink)

    this.client = new ApolloClient({ link, cache })
    this.mutate = this.client.mutate.bind(this.client)
    this.query = this.client.query.bind(this.client)
  }
  register ({ identity }) {
    return this.mutate({ variables: { identity }, mutation: gql`mutation Register($identity: IdentityInput!) {
      register(identity: $identity) {
        accessToken
        user { id, name }
      }
    }
    ` })
  }
}
