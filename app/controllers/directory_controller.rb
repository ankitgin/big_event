class DirectoryController < ApplicationController
    def show
        if session[:level] != 'EX'
            flash[:warning] = "User does not have access to staff directory."
            redirect_to root_path
        end
    end
end
