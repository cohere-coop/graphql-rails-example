# frozen_string_literal: true

module Mutations
  class ApplicationMutation < GraphQL::Schema::Mutation
    def guest?
      current_user.is_a?(Guest)
    end

    def current_user
      context[:current_user]
    end
  end
end
