# frozen_string_literal: true

module Types
  class User < BaseObject
    implements GraphQL::Relay::Node.interface
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true

    field :tasks, Task.connection_type, null: true
  end
end
