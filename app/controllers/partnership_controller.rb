class PartnershipController < ApplicationController

  def show
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
        
    if(session[:user_email].present?)  
        if(session[:partnershipnumber].present?)
            @current_partnership = session[:partnershipnumber]
            redirect_to(partnership_path(:id => @current_partnership))
        else
            flash[:notice] = "User partnership unspecified"
            redirect_to root_path
        end
    else
      flash[:notice] = "User not signed in"
      redirect_to root_path
    end
  end

end
