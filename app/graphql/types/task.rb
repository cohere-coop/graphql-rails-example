module Types
  class Task < BaseObject
    implements GraphQL::Relay::Node.interface
    field :id, ID, null: false

    field :title, String, null: true
    field :description, String, null: true

    field :task_lists, TaskList.connection_type, null: true
  end
end
