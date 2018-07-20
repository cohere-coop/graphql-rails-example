class EmailAndPasswordIdentity < Identity
  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
  validates_confirmation_of :password, allow_blank: true
  validate do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end

  def self.authenticate(identity)
    record = find_by(identifier: identity.email_and_password.email)
    record.authenticate(identity.email_and_password.password)
  end
end
