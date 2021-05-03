module ApplicationHelper
    def is_logged_in?
        if !session[:access_token].nil? && User.staff_member?(User.get(session[:user_email]))
            return true
        else
            session.clear
            return false            
        end
    end

    def current_user
        if is_logged_in?
            @current_user ||= User.new(User.get(session[:user_email]))
        else
            @current_user = nil
        end
        @current_user
    end

end
