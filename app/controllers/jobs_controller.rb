class JobsController < ApplicationController
    def show
        jobs_id = params[:id]
        job = ::Job.show(jobs_id)
        
        render 'show', locals: { job: job[:data] }
    end
end
