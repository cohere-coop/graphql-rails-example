module Mutations
  # Retrieves a user identified by the provided identity
  class Authenticate < ApplicationMutation
    argument :identity, Types::IdentityInput, required: true
    payload_type Types::UserSession

    def resolve(identity:)
      Identity.authenticate(credentials: identity)
    end
  end
end
