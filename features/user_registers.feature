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
    mutation Register($identity: IdentityInput!) {
      register(identity: $identity) {
        accessToken
        user {
          id
          email
        }
        identity {
          identifier
          type
        }
      }
    }
    """
    Then the response has no errors
    And the response has an ID at "register.user.id"
    And the response has a functioning access token at "register.accessToken"
    And the response has "{{ me.email }}" at "register.identity.identifier"
    And the response has "EmailAndPasswordIdentity" at "register.identity.type"

