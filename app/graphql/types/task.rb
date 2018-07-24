module Types
  class Task < BaseObject
    implements GraphQL::Relay::Node.interface
    field :title, String, null: true
    field :description, String, null: true
  end
end
