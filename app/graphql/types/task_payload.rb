module Types
  class TaskPayload < PayloadObject
    field :task, Task, null: true

    def task
      object
    end
  end
end
