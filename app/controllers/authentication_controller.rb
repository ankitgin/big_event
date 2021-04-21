class AuthenticationController < ApplicationController
    def googleAuth
        # Get access tokens from the google server
        data = request.env["omniauth.auth"].info
        user_doc = User.from_omniauth(data)

        #reject user if needed (not staff member)
        if !User.staff_member?(user_doc)
            url = "https://bigevent.tamu.edu/"
            redirect_to url
        else
            log_in(user_doc)

            @user = User.new(data)
            # Access_token is used to authenticate request made from the rails application to the google server
            # Refresh_token to request new access_token
            # Note: Refresh_token is only sent once during the first request
            @google_refresh_token = refresh_token(user_doc, @google_refresh_token)
            User.save(user_doc)
            redirect_to root_path
        end
    end
end