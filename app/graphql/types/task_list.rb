module Types
  class TaskList < BaseObject
    implements GraphQL::Relay::Node.interface
    field :id, ID, null: false
    field :name, String, null: true
    field :owners, [User], null: true
    field :tasks, [Task], null: true
  end
end
