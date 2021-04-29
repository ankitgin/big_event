module ApplicationHelper
    def is_logged_in?
        puts !session[:access_token].nil? 
        !session[:access_token].nil? 
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
