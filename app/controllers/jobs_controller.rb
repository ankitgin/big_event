class JobsController < ApplicationController
    def show
        job = ::Job.show(params[:id])
        render 'show', locals: { job: job[:data] }
    end
end
