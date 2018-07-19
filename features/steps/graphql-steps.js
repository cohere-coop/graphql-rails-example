const { Given, When, Then } = require('cucumber')

Given('the following variables', function (variables) {
  this.variables = variables
})

When('I run the following mutation', function (graphql) {
  this.mutate(graphql)
})

Then('the response has {string} at {string}', function (data, lookup) {
  return 'pending'
})

Then('the response has a UUID at {string}', function (data, lookup) {
  return 'pending'
})
