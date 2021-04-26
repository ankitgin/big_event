Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    #callback_path: '/auth/google_oauth2/callback',
    scope: 'userinfo.email, userinfo.profile',
    prompt: 'consent',
    access_type: 'offline',
    redirect_uri: Rails.configuration.domain_name + 'auth/google_oauth2/callback',
  }
end