
const { HttpLink } = require('apollo-link-http')
const { split, ApolloLink } = require('apollo-link')
const { ApolloClient } = require('apollo-client')
const { InMemoryCache } = require('apollo-cache-inmemory')
const fetch = require('node-fetch')
const { getMainDefinition } = require('apollo-utilities')

const ActionCableLink = require('graphql-ruby-client/subscriptions/ActionCableLink')

module.exports = ({ endpoint, cable, token }) => {
  const cache = new InMemoryCache()
  const httpLink = new HttpLink({ uri: endpoint, fetch })
  const wsLink = new ActionCableLink({ cable })

  const authLink = new ApolloLink((operation, forward) => {
    if (token) {
      operation.setContext({
        headers: { authorization: `Bearer ${token}` }
      })
    }
    return forward(operation)
  })

  const link = authLink.concat(split(
    // split based on operation type
    ({ query }) => {
      const { kind, operation } = getMainDefinition(query)
      return kind === 'OperationDefinition' &&
        operation === 'subscription'
    },
    wsLink,
    httpLink
  ))

  return new ApolloClient({ link, cache })
}
