class AuthenticationController < ApplicationController
    def googleAuth
        # Get access tokens from the google server
        access_token = request.env["omniauth.auth"]
        puts "THIS IS THE ACCESS TOKEN: "
        puts access_token
        user = User.from_omniauth(access_token)
        log_in(user)
        # Access_token is used to authenticate request made from the rails application to the google server
        # Refresh_token to request new access_token
        # Note: Refresh_token is only sent once during the first request
        refresh_token = access_token.credentials.refresh_token
        user.google_refresh_token = refresh_token if refresh_token.present?
        user.save
        redirect_to root_path
    end
end
