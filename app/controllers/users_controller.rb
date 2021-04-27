class UsersController < ApplicationController
    def index
        if session[:level] != 'EX'
            flash[:warning] = "User does not have access to staff directory."
            redirect_to root_path
        end
        @users = User.all
        respond_to do |format|
            format.html
            format.csv { send_data User.to_csv, filename: "TBE-staff-directory-#{Date.today}.csv" }
        end
    end

    def upload
        csv_attachment = params[:attachments]

        if !User.valid_csv?(csv_attachment)
            flash[:warning] = "Invalid CSV File"
            redirect_to users_path
        else 
            User.update_from_csv(csv_attachment)
            flash[:notice] = "Staff directory updated from file: '#{csv_attachment.original_filename}'"
            redirect_to users_path
        end
    end
end
