class PartnershipController < ApplicationController

  def show
    if(session[:user].present?)
      @current_user = params[:user]
    end

    if(params[:id].present?)
        @current_partnership = params[:id]
    else
      flash[:warning] = "Partnership unspecified"
      redirect_to root_path
    end
    @jobs_to_show = ::Job.jobs_for_partnership(@current_partnership)
    @partnerships = ::Job.all_partnerships
  end

  def check_user
    @current_user = nil
    if(params[:user].present?)
      @current_user = params[:user]
      @current_partnership = ::Job.partnership_for_user(@current_user)
      redirect_to(partnership_path(:id => @current_partnership))
    else
      flash[:warning] = "User not signed in"
      redirect_to root_path
    end
  end

end