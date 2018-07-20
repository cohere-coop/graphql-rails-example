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
    When I run the following mutation
    """
    mutation Authenticate($identity: IdentityInput!) {
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
    And the response has "{{ me.email }}" at "authenticate.user.email"


  Scenario: Invalid username and password authentication
    Given I have already registered
    And the following variables
    """
    {
      "identity": {
        "emailAndPassword": { "email": "{{ me.email }}", "password": "an-invalid-password" }
      }
    }
    """
    When I run the following mutation
    """
    mutation Authenticate($identity: IdentityInput!) {
      authenticate(identity: $identity) {
        accessToken
        user {
          id
          email
        }
        errors { status, title, detail }
      }
    }
    """
    Then the response does not have a functioning access token at "authenticate.accessToken"
    And the response is null at "authenticate.user.id"
    And the response is null at "authenticate.user.id"
    And the response has "401" at "authenticate.errors[0].status"
    And the response has "Invalid Credentials" at "authenticate.errors[0].title"
    And the response has "Invalid email or password" at "authenticate.errors[0].detail"

