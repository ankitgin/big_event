class PartnershipController < ApplicationController

  def show
      if(params[:id].present?)
        @current_partnership = params[:id]
      else
        @current_partnership = 'all'
      end
      @jobs_to_show = ::Job.jobs_for_partnership(params[:id])
      @partnerships= ::Job.all_partnerships
  end
end