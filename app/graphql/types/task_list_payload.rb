module Types
  class TaskListPayload < PayloadObject
    field :task_list, TaskList, null: true

    def task_list
      object
    end
  end
end
