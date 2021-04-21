require './app/models/base.rb'

class User < Base
    attr_accessor :email, :access_token, :first_name, :google_refresh_token, :last_name, :level, :uin

    def initialize(data)
        @email = data.email
        @access_token = data.access_token
        @first_name = data.first_name
        @google_refresh_token = data.google_refresh_token.present? ? data.google_refresh_token : nil
        @last_name = data.last_name
        @level = data.level
        @uin = data.uin
    end

    def self.staff_member?(user_doc)
        return user_doc.get().exists?
    end

    def self.from_omniauth(data)
        # data = access_token.info        
        db_ref_staff.doc data.email
        # user = User.where(email: data['email'])
    end

    def self.save(user_doc)
        user_data = {
            AccessToken: @access_token,
            Email: @email,
            FirstName: @first_name,
            GoogleRefreshToken: @google_refresh_token,
            LastName: @last_name,
            Level: @level,
            UIN: @uin
        }
        user_doc.set(user_data)
    end
    
    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col "staff"
        end
        
end