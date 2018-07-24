Feature: User adds other user to task list
  In order to stay up to date with things other people want to do
  As a user
  I would like to add other users to a task list I own


  Scenario: User adds user to task list
    Given I am making requests as an authenticated member
    And I have a task list
    And another user exists
    And the following variables
    """
    {
      "taskLists": ["{{ me.taskLists.0.id}}"],
      "users": ["{{ users.1.id }}"]
    }
    """
    When I run the following mutation
    """
    mutation AddUsersToTaskLists($taskLists: [ID!]!, $users: [ID!]!) {
      taskListsAddUsers(taskLists: $taskLists, users: $users) {
        memberships {
          taskList { id, owners { edges { node { id } } } }
          user { id }
        }
        errors { title, status, detail }
      }
    }
    """
    Then the response has no system level errors
    And the response has "{{ users.1.id }}" at "taskListsAddUsers.memberships.0.user.id"
    And the response has "{{ me.taskLists.0.id }}" at "taskListsAddUsers.memberships.0.taskList.id"
    And the response has "{{ me.id }}" at "taskListsAddUsers.memberships.0.taskList.owners.edges.0.node.id"
    And the response has "{{ users.1.id }}" at "taskListsAddUsers.memberships.0.taskList.owners.edges.1.node.id"


  Scenario: User adds existing list member to list
    Given I am making requests as an authenticated member
    And I have a task list
    And the following variables
    """
    {
      "taskLists": ["{{ me.taskLists.0.id}}"],
      "users": ["{{ me.id }}"]
    }
    """
    When I run the following mutation
    """
    mutation AddUsersToTaskLists($taskLists: [ID!]!, $users: [ID!]!) {
      taskListsAddUsers(taskLists: $taskLists, users: $users) {
        memberships {
          taskList { id, owners { edges { node { id } } } }
          user { id }
        }
        errors { title, status, detail }
      }
    }
    """
    Then the response has no system level errors
    And the response has "Unable to Add User to Task List" at "taskListsAddUsers.errors.0.title"
