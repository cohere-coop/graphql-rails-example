Feature: User adds task list
  In order to group tasks in a way that I can approach effectively
  As a user
  I would like to be able to create a task list to organize my tasks



  Scenario: User creates task list
    Given I am making requests as an authenticated member
    And the following variables
    """
    {
      "taskList": {
        "name": "groceries"
      }
    }
    """
    When I run the following mutation
    """
    mutation CreateTaskList($taskList: TaskListInput!) {
      createTaskList(taskList: $taskList) {
        taskList {
          id
          owners { edges { cursor, node { id } } }
          name
          tasks { edges { cursor, node { id, title, description } } }
        }
        errors { status, title, detail }
      }
    }
    """
    Then the response has no system level errors
    And the response is undefined at "createTasklist.errors"
    And the response has an ID at "createTaskList.taskList.id"
    And the response is empty at "createTaskList.taskList.tasks.edges"
    And the response has "groceries" at "createTaskList.taskList.name"
    And the response has "{{ me.id }}" at "createTaskList.taskList.owners.edges[0].node.id"



