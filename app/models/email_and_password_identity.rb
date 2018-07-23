# frozen_string_literal: true

#  A particular user/password combination
class EmailAndPasswordIdentity < Identity
  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
  validates_confirmation_of :password, allow_blank: true
  validate do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end

  def self.register(credentials)
    identity = EmailAndPasswordIdentity.new(identifier: credentials.email_and_password.email,
                                            password: credentials.email_and_password.password, user: User.new)
    return GuestIdentity.new(identity: identity) unless identity.valid?
    identity.save
    identity
  end

  def self.authenticate(identity)
    record = find_by(identifier: identity.email_and_password.email)
    return record if record.authenticate(identity.email_and_password.password)
    record.errors.add(:credentials, "Invalid email or password")
    GuestIdentity.new(identity: record)
  end
end
