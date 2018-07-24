Feature: User adds task
  In order to build a list of things to do
  As a user
  I would like to be able to create a task


  Scenario: User creates task
    Given I am making requests as an authenticated member
    And I have a task list
    And the following variables
    """
    {
      "task": {
        "title": "Do a thing!",
        "description": "You got to do this! It's so great!"
      },
      "taskLists": ["{{ me.taskLists.0.id }}"]
    }
    """
    When I run the following mutation
    """
    mutation CreateTask($task: TaskInput!, $taskLists: [ID!]) {
      tasksCreate(task: $task, taskLists: $taskLists) {
        task {
          id
          title
          description
          taskLists { id }
        }
        errors { status, title, detail }
      }
    }
    """
    Then the response has no system level errors
    And the response is undefined at "taskCreate.errors"
    And the response has "{{ me.taskLists.0.id }}" at "tasksCreate.task.taskLists[0].id"
    And the response has "Do a thing!" at "tasksCreate.task.title"
    And the response has "You got to do this! It's so great!" at "tasksCreate.task.description"
