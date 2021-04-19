require './app/models/base.rb'

class User < Base
    def self.from_omniauth(access_token)
        #data = access_token.info
        #user = User.where(email: data['email']).first
        
        query = db_ref_staff.where "Email", "=", "christianjsmith17@tamu.edu"

        # Uncomment the section below if you want users to be created if they don't exist
        # unless user
        #     user = User.create(name: data['name'],
        #        email: data['email'],
        #        password: Devise.friendly_token[0,20]
        #     )
        # end
    end
    
    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col "staff"
        end
end