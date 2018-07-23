# frozen_string_literal: true

#  A particular user/password combination
class EmailIdentity < Identity
  def self.register(credentials)
    identity = new(identifier: credentials.email_and_password.email,
                   user: User.new(password: credentials.email_and_password.password))

    return GuestIdentity.new(identity: identity) unless identity.valid?

    identity.save
    identity
  end

  def self.authenticate(identity)
    record = find_by(identifier: identity.email_and_password.email)
    return record if record.user.authenticate(identity.email_and_password.password)
    record.errors.add(:credentials, "Invalid email or password")
    GuestIdentity.new(identity: record)
  end
end
