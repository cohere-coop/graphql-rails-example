Feature: User receives live updates to task list
  In order to not duplicate work
  As a user
  I would like to receive updates to a task list in real time


  Scenario: User is informed when new task is added
    Given I am making requests as an authenticated member
    And I have a task list
    And the following variables
    """
    {
      "taskList": "{{ me.taskLists.0.id }}"
    }
    """
    And the following subscription
    """
    subscription TaskAdded($taskList: ID!) {
      taskAdded(taskList: $taskList) {
        task {
          id
          title
          description
        }
      }
    }
    """
    When a task is added to the task list
    Then the subscription response has "{{ tasks[0].title }}" at "taskAdded.task.title"
    And the subscription response has an ID at "taskAdded.task.id"
