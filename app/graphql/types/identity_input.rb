# frozen_string_literal: true

module Types
  # Adapter to allow different identification types on the same mutation
  class IdentityInput < BaseInputObject
    argument :email_and_password, Types::EmailAndPasswordIdentityInput, required: false
  end
end
