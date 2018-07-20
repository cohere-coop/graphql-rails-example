# frozen_string_literal: true

# A User who has registered for the service
class User < ApplicationRecord
  has_many :identities
  has_many :access_token_identities, class_name: :AccessTokenIdentity
  has_many :email_and_password_identities, class_name: :EmailAndPasswordIdentity

  def access_token
    access_token_identities.first.identifier
  end

  def email
    email_and_password_identities.first.identifier
  end
end
