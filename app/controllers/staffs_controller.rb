class StaffsController < ApplicationController
  #ApplicationController

  def index
    @current_partnership = "P1"
    @partnerships=["P1","P2","P3"]
  end

end