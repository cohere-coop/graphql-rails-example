module Types
  class TaskListMembership < BaseObject
    field :task_list, TaskList, null: true
    field :user, User, null: true
  end
end

