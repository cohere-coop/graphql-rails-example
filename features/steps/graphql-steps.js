const { Given, When, Then } = require('cucumber')
const { expect } = require('chai')

Given('the following variables', function (variables) {
  this.variables = variables
})

When('I run the following mutation', function (graphql) {
  return this.mutate(graphql)
})

When('I run the following query', function (graphql) {
  return this.query(graphql)
})

Then('the response has {string} at {string}', function (data, loc) {
  return expect(this.lookup(loc)).to.equal(this.interpolate(data))
})

Then('the response has {int} items at {string}', function (count, loc) {
  return expect(this.lookup(loc).length).to.equal(count)
})

Then('the response is true at {string}', function (loc) {
  return expect(this.lookup(loc)).to.be.true
})

Then('the response is null at {string}', function (loc) {
  return expect(this.lookup(loc)).to.be.null
})

Then('the response is undefined at {string}', function (loc) {
  return expect(this.lookup(loc)).to.be.undefined
})

Then('the response has no system level errors', function () {
  return expect(this.response.errors).to.be.undefined
})

Then('the response has an ID at {string}', function (loc) {
  return expect(this.lookup(loc)).not.to.be.empty
})

Then('the response is empty at {string}', function (loc) {
  return expect(this.lookup(loc)).to.be.empty
})
