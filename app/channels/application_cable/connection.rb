module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_current_user
    end

    def find_current_user
      AccessTokenIdentity.authenticate(
        OpenStruct.new(access_token: OpenStruct.new(token: request.query_parameters[:access_token]))
      )&.user || Guest.new
    end
  end
end
