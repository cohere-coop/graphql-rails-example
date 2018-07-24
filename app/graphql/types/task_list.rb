module Types
  class TaskList < BaseObject
    implements GraphQL::Relay::Node.interface
    field :id, ID, null: false
    field :name, String, null: true
    field :owners, User.connection_type, null: true
    field :tasks, Task.connection_type, null: true
  end
end
