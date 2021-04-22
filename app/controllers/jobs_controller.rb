class JobsController < ApplicationController

  def show
    job = ::Job.show(params[:id])
    render 'show', locals: { job: job[:data] }
  end

  def update
    job = ::Job.update(params)
    redirect_to(job_path(id: job[:data][:JobNumber]))
  end
end
