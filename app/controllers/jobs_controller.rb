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
    params.permit(:FirstName, :JobNumber, :PhoneNumber, :BestTimeToCall, :Partnership, :Status, :Address, :JobDescription, :Comment, :S, :M, :L, :XL, :XXL, 'Parking Pass Required', 'Completable in Rain', 'All tools provided', 'Ordering T-Shirts', 'PaintGallons Needed', 'PaintGallons Provided', 'PaintBrushes Provided', 'PaintBrushes Needed', 'PaintRollers Provided', 'PaintRollers Needed', 'PaintScrapers Provided', 'PaintScrapers Needed', 'PaintTrays Provided', 'PaintTrays Needed', 'RollerExtensions Provided', 'RollerExtensions Needed', 'Ladders Provided', 'Ladders Needed', 'DropCloths Provided', 'DropCloths Needed', 'TrashBags Provided', 'TrashBags Needed', 'Mops Provided', 'Mops Needed', 'Brooms Provided', 'Brooms Needed', 'DustPans Provided', 'DustPans Needed', 'PaperTowels Provided', 'PaperTowels Needed', 'ScouringPads Provided', 'ScouringPads Needed', 'GardenSpades Provided', 'GardenSpades Needed', 'HandClippers Provided', 'HandClippers Needed', 'Hammers Provided', 'Hammers Needed', 'Saws Provided', 'Saws Needed', 'HardRakes Provided', 'HardRakes Needed', 'LeafRakes Provided', 'LeafRakes Needed', 'Hoes Provided', 'Hoes Needed', 'HedgeShears Provided', 'HedgeShears Needed', 'SpadeShovels Provided', 'SpadeShovels Needed', 'FlatShovels Provided', 'FlatShovels Needed', 'TrenchingShovels Provided', 'TrenchingShovels Needed', 'TreeTrimmers Provided', 'TreeTrimmers Needed', 'Axes Provided', 'Axes Needed', 'Gloves Provided', 'Gloves Needed')
  end
end
