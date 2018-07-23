# frozen_string_literal: true

module Mutations
  # Registers a new user with the identity provided
  class Register < ApplicationMutation
    argument :identity, Types::IdentityInput, required: true
    payload_type Types::UserSession

    def resolve(identity:)
      Identity.register(credentials: identity)
    end
  end
end
