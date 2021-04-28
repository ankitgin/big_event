module ApplicationHelper
    def is_logged_in?
        session[:access_token] 
    end

    def level
        @level ||= session[:level] if is_logged_in?
    end 
end
