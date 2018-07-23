Feature: User registers
  In order to persist data specific to me
  As a User
  I would like to be able to register an account

  Scenario: Email and password registration
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
        errors { status, title, detail }
      }
    }
    """
    Then the response has no system level errors
    Then the response is empty at "register.errors"
    And the response has an ID at "register.user.id"
    And the response has a functioning access token at "register.accessToken"
    And I can authenticate with my email and password via the authenticate mutation


  Scenario: Email already taken
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
    mutation Register($identity: IdentityInput!) {
      register(identity: $identity) {
        accessToken
        user {
          id
          email
        }
        errors { status, title, detail }
      }
    }
    """
    Then the response has no system level errors
    And the response is null at "register.user"
    And the response is null at "register.accessToken"
    And the response has "has already been taken" at "register.errors[0].detail"
    And the response has "422" at "register.errors[0].status"
    And the response has "Validation Error" at "register.errors[0].title"

