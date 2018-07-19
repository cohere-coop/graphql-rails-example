Feature: User authenticates
  In order to securely perform actions with the API
  As a User
  I would like to be able to authenticate as me

  Scenario: Username and password authentication
    Given I have already registered
    And the following variables
    """
    {
      "identity": {
        "emailAndPassword": { "email": "{{ me.email }}", "password": "{{ me.password }}" }
      }
    }
    """
    When I execute the following graphql
    """
    mutation Authenticate($identity: Identity!) {
      authenticate(identity: $identity) {
        accessToken
        user {
          id
          email
        }
      }
    }
    """
    Then the response has "{{ me.id }}" at "authenticate.user.id"
    And the response has a functioning access token at "authenticate.accessToken"
    And the response has "{{ me.email }}" at "authenticate.user.id"
