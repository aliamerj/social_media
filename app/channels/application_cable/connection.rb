module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
    end

    private

      def find_user
        if (user = env["warden"].user)
          puts "User IS logged in"
          user
        else
          puts "User IS NOT logged in"
          reject_unauthorized_connection
        end
      end
  end
end
