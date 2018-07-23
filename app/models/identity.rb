# frozen_string_literal: true

# Identifies a particular authentication method in the system, such as email and password, oauth, access token
# etc.
class Identity < ApplicationRecord
  validates :identifier, uniqueness: { scope: :type }
  has_secure_password validations: false
  belongs_to :user

  def self.register(credentials:)

    identity = identification_strategy_for(credentials: credentials).register(credentials)
    AccessTokenIdentity.create(user: identity.user) if identity.persisted?
    identity
  end

  def self.authenticate(credentials:)
    identification_strategy_for(credentials: credentials).authenticate(credentials)
  end

  def self.identification_strategy_for(credentials:)
    if credentials.email_and_password
      EmailAndPasswordIdentity
    elsif credentials.access_token
      AccessTokenIdentity
    end
  end
end
