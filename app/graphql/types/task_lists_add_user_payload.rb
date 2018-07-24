module Types
  class TaskListsAddUserPayload < PayloadObject
    field :memberships, [TaskListMembership], null: true
  end
end
