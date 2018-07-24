Feature: User retrieves tasks
  In order to know what I've got to do
  As a user
  I would like to be able to list my tasks


  Scenario: Retrieving a small set of tasks
    Given I am making requests as an authenticated member
    And I have a task list
    And I have 20 tasks assigned to that task list
    And the following variables
    """
    {
      "first": 10
    }
    """
    When I run the following query
    """
    query Tasks($first: Int) {
      me {
        tasks(first: $first) {
          edges {
            cursor
            node { id, title, description }
          }
          pageInfo {
            hasNextPage

          }
        }
      }
    }
    """
    Then the response has no system level errors
    And the response has 10 items at "me.tasks.edges"
    And the response is true at "me.tasks.pageInfo.hasNextPage"

