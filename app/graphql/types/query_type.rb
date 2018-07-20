# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :me, User, null: false, description: "Authenticated user"

    def me
      context[:current_user]
    end
  end
end
