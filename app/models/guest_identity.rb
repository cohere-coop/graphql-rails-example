class GuestIdentity
  include ActiveModel::Model

  attr_accessor :identity

  def user
    nil
  end

  def errors
    identity.errors
  end
end
