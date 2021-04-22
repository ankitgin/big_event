require 'oauth2'

module AuthenticationHelper

    # Save user info to session for later use, reduce reads to db
    def log_in(user, credentials)
        session[:user_email] = user[:Email]
        session[:expires_at] = credentials.expires_at
        session[:access_token] = credentials.token
        
        if credentials.refresh_token.present?
            session[:refresh_token] = credentials.refresh_token
        end
        
        # ID is identified for user for uri, exec does not have partner
        session[:id] = user[:PartnershipNumber] == "" ? user[:email] : user[:PartnershipNumber]
    
        puts "User credentials in session:"
        puts session[:user_email]
        puts session[:expires_at]
        puts session[:access_token]
        puts session[:refresh_token]
        puts session[:id]
    end

    def token_expired?
        expiry = Time.at(session[:expires_at])
        return expiry < Time.now
    end

    def refresh_token_if_expired
        if token_expired?
            strategy = OmniAuth::Strategies::GoogleOauth2.new(nil, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
            client = strategy.client
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