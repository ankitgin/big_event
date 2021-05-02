class JobsController < ApplicationController

  def show
    job = ::Job.show(params[:id])
    render 'show', locals: { job: job[:data] }
  end
  
  def edit
    job = ::Job.show(params[:id])
    all_status = ::Job.unique_status()
    partnerships = ::Job.all_partnerships
    render 'edit', locals: { job: job[:data], all_status: all_status, partnerships: partnerships }
  end

  def update
    job = ::Job.update(edit_job_params)
    redirect_to(job_path(id: job[:data][:JobNumber]))
  end
  
  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def edit_job_params
    params.permit(:FirstName, :JobNumber, :PhoneNumber, :BestTimeToCall, :Partnership, :Status, :Address, :JobDescription, :Comment)
  end
end
