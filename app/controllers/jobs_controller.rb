class JobsController < ApplicationController

  def index
    @id = 3
  end

  def show
    job = ::Job.show(params[:id])
    render 'show', locals: { job: job[:data] }
  end
end
