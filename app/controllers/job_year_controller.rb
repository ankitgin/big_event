class JobYearController < ApplicationController
    def show
        if(params[:id].present?)
            @current_job_year = params[:id]
            session[:job_id] = params[:id]
        else
            flash[:warning] = "Job year unspecified"
            redirect_to root_path
        end
        
        @all_job_years = Job.all_job_years
        @jobs = Job.all_jobs_in_year(@current_job_year)
        
        respond_to do |format|
            format.html
            format.csv { send_data Job.to_csv_jobs(@jobs), filename: "TBE-jobs-#{@current_job_year}.csv" }
        end
    end
    
    def upload_jobs
        @current_job_year = session[:job_id]
        csv_attachment = params[:attachments]

        if !User.valid_csv?(csv_attachment)
            flash[:warning] = "Invalid CSV File"
            redirect_to job_year_path(:id => @current_job_year)
        else 
            Job.update_from_csv(csv_attachment, @current_job_year)
            flash[:notice] = "#{@current_job_year} jobs updated from file: '#{csv_attachment.original_filename}'"
            redirect_to job_year_path(:id => @current_job_year)
        end
    end
end