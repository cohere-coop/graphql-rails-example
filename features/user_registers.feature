Feature: User registers
  In order to persist data specific to me
  As a User
  I would like to be able to register an account

  Scenario: Username and password registration
    Given I have not yet registered
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
    mutation Register($identity: Identity!) {
      register(identity: $identity) {
        accessToken
        user {
          id
          email
        }
      }
    }
    """
    Then the response has a UUID at "authenticate.user.id"
    And the response has a functioning access token at "authenticate.accessToken"
    And the response has "{{ me.email }}" at "authenticate.user.id"

