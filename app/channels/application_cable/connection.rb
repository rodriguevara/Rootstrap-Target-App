module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      uid = request.params[:uid]
      access_token = request.params[:'access-token']
      client_id = request.params[:client]

      user = User.find_by(uid:)

      if user&.valid_token?(access_token, client_id)
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
