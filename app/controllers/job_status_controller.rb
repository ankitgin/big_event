class JobStatusController < ApplicationController
  before_action :check_login

  def show
    all_status = ::Job.all_status()
    status_counts = Hash.new
    all_status.each do |status|
      if status_counts[status]
        status_counts[status] += 1
      else
        status_counts[status] = 1
      end
    end
    unique_status = ::Job.unique_status()
    unique_status.each do |status|
     if !status_counts.key?(status)
       status_counts[status] = 0
     end
    end
    @status_graph = hash_to_a(status_counts)
  end

  def hash_to_a(hash)
    hash.map do |k, v|
      [k, v]
    end
  end

  def check_login
    if(!session[:user_email].present?)
      flash[:notice] = "User not signed in"
      redirect_to root_path
    end
  end
end