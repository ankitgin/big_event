class JobsController < ApplicationController

  def index
    @current_partnership = "P1"
    @partnerships=["P1","P2","P3"]
  end

  def show
    job = ::Job.show(params[:id])
    render 'show', locals: { job: job[:data] }
  end
end
