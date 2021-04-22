class AuthenticationController < ApplicationController
    def googleAuth
        # Get access tokens from the google server
        auth_hash = request.env["omniauth.auth"]
        info = auth_hash.info
        
        credentials = auth_hash.credentials
        user_doc = User.from_omniauth(info)

        #reject user if needed (not staff member)
        reject_url = "https://bigevent.tamu.edu/"
        if !User.staff_member?(user_doc)
            redirect_to reject_url
        else
            log_in(user_doc, credentials)
            @user = User.new(user_doc, credentials)
            # Access_token is used to authenticate request made from the rails application to the google server
            # Refresh_token to request new access_token
            # Note: Refresh_token is only sent once during the first request
            refresh_token_if_expired()
            redirect_to root_path
            
        end
    end

    # def redirect_to_level(level, id)
    #     case level
    #     when 'SA'
    #         redirect_to partnership_path(id)
    #     when 'CM'
    #         redirect_to root_path
    #     when 'EZ'
    #         redirect_to root_path
    #     else 
    #         redirect_to reject_url
    #     end
    # end
end