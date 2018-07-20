# frozen_string_literal: true

module Types
  class EmailAndPasswordIdentityInput < BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
