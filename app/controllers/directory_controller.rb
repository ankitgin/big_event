class DirectoryController < ApplicationController
    def index
        if session[:level] != 'EX'
            flash[:warning] = "User does not have access to staff directory."
            redirect_to root_path
        end
        # @users = User.all_users()
        @users = []
        
        User.update_from_csv('Mock_Staff_Directory.csv')

    end
end
