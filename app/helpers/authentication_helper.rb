module AuthenticationHelper
    def log_in(user)
        email = ''
        user.get do |staff|
            email << staff.data.email
        end
        session[:user_email] = email
    end

    def refresh_token(user, google_refresh_token)
        user.get do |staff| 
            if google_refresh_token == nil
                @google_refresh_token = staff.data.google_refresh_token
            end
        end
    end 
end