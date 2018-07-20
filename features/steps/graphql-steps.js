const { Given, When, Then } = require('cucumber')
const { expect } = require('chai')

Given('the following variables', function (variables) {
  this.variables = variables
})

When('I run the following mutation', function (graphql) {
  return this.mutate(graphql)
})

Then('the response has {string} at {string}', function (data, loc) {
  return expect(this.lookup(loc)).to.equal(this.interpolate(data))
})

Then('the response has no errors', function () {
  return expect(this.response.errors).to.be.undefined
})

Then('the response has an ID at {string}', function (loc) {
  return expect(this.lookup(loc)).not.to.be.empty
})
