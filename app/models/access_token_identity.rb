class AccessTokenIdentity < Identity
  before_create :generate_token

  def generate_token
    self.identifier ||= SecureRandom.hex(64)
  end

  def self.authenticate(identity)
    find_by(identifier: identity.access_token.token)
  end
end
