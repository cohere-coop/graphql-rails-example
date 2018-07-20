class GuestIdentity
  include ActiveModel::Model

  attr_accessor :identity

  def user
    @user ||= Guest.new
  end

  def errors
    [
      { status: "401", title: "Invalid Credentials", detail: "Invalid email or password" }
    ]
  end

  def detail
    return "Invalid email or password" if identity.email_and_password
    return "Invalid access token" if identity.access_token
  end
end
