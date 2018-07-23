# frozen_string_literal: true

module Types
  # Payload object that includes an access token for the returned user
  class UserSession < PayloadObject
    field :access_token, String, null: true
    field :user, Types::User, null: true
    field :identity, Types::Identity, null: true
    delegate :access_token, to: :user, allow_nil: true

    def identity
      object
    end
  end
end
