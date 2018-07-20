# frozen_string_literal: true

module Types
  class User < BaseObject
    field :id, ID, null: true
    field :name, String, null: true
    field :email, String, null: true
  end
end
