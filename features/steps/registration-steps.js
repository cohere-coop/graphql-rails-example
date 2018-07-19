const { Given, Then } = require('cucumber')
const cuid = require('cuid')

Given('I have not yet registered', function () {
  this.data.me = { email: `user-${cuid()}@example.com`, password: 'password' }
})
Given('I have already registered', () => {
  return 'pending'
})

Then('the response has a functioning access token at {string}', (lookup) => {
  return 'pending'
})
