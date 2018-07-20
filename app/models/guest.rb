# frozen_string_literal: true

# Null object to represent a user who has not yet registered or authenticated
class Guest
  def access_token
    nil
  end

  def id
    nil
  end

  def email
    nil
  end
end
