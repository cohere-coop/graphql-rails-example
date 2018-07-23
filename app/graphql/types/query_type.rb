# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :me, User, null: true, description: "Authenticated user"

    def me
      return nil if context[:current_user].is_a? Guest
      context[:current_user]
    end
  end
end
