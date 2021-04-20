module AuthenticationHelper
    def log_in(user)
        email = ''
        user.get do |staff|
            email << staff.data[:Email]
        end
        session[:user_email] = email
    end
end