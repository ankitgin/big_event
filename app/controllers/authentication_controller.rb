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
            @user = User.new(user_doc)
            # Access_token is used to authenticate request made from the rails application to the google server
            # Refresh_token to request new access_token
            # Note: Refresh_token is only sent once during the first request
            refresh_token_if_expired()
            redirect_to root_path
            
        end
    end

    private 
        def log_in(user, credentials)
            session[:user_email] = user[:email]
            session[:level] = user[:level]
            session[:expires_at] = credentials.expires_at
            session[:access_token] = credentials.token
            
            if credentials.refresh_token != ""
                session[:refresh_token] = credentials.refresh_token
            end
            
            puts "User credentials in session:"
            puts session[:user_email]
            puts session[:level]
            puts session[:expires_at]
            puts session[:access_token]
            puts session[:refresh_token]
        end

        def refresh_token_if_expired
            if token_expired?
                strategy = OmniAuth::Strategies::GoogleOauth2.new(nil, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
                client = strategy.client
                if !session[:refresh_token]
                    redirect_to Rails.configuration.domain_name + 'auth/:provider/callback'
                else  
                    token = OAuth2::AccessToken.new(
                        client,
                        session[:access_token],
                        refresh_token: session[:refresh_token]
                    )
                    new_token = token.refresh!
                    if new_token.present?
                        session[:access_token] = new_token.token
                        session[:expires_at] = new_token.expires_at
                        session[:refresh_token] = new_token.refresh_token
                    end
                end
            end
        end

        def token_expired?
            !session[:expires_at] || Time.at(session[:expires_at]) > Time.now 
        end
end