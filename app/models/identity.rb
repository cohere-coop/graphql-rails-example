# frozen_string_literal: true

# Identifies a particular authentication method in the system, such as email and password, oauth, access token
# etc.
class Identity < ApplicationRecord
  validates :identifier, uniqueness: true
  has_secure_password validations: false
  belongs_to :user

  def self.register(identity:)
    return unless identity.email_and_password
    identity = EmailAndPasswordIdentity.new(identifier: identity.email_and_password.email,
                                            password: identity.email_and_password.password)

    identity.user = User.create
    identity.save
    AccessTokenIdentity.create(user: identity.user)
    identity
  end

  def self.authenticate(identity:)
    identification_strategy = if identity.email_and_password
                                 EmailAndPasswordIdentity
                              elsif identity.access_token
                                AccessTokenIdentity
                              end

    identification_strategy.authenticate(identity)
  end
end
