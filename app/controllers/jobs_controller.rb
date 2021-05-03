class JobsController < ApplicationController
  before_action :check_login

  def show
    job = ::Job.show(params[:id])[:data]
    comm_email = ""
    comm_email = job[:CommitteeEmail] if(job[:CommitteeEmail].present?)

    exec_email = ""
    exec_email = job[:ExecEmail] if(job[:ExecEmail].present?)
    access_array = access_control(job[:Status],session[:level],session[:user_email],comm_email,exec_email)
    render 'show', locals: { job: job , action_button_value: access_array[0], action_button_access: access_array[1], cancellable: access_array[2]}
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

  def update_job_status
    job = params[:job_data]
    if (job[:Status]=="Not Completed")
      job[:Status]="Job Check Scheduled"
    elsif (job[:Status]=="Job Check Scheduled")
      job[:Status]="Completed by SA"
    elsif (job[:Status]=="Completed by SA")
      job[:Status]="Submitted to CM"
      if(session[:user_email].present?)
        job[:CommitteeEmail] = ::User.get_superior_email(session[:user_email])
      end
    elsif (job[:Status]=="Submitted to CM")
      job[:Status]="Submitted to EX"
      if(session[:user_email].present?)
        job[:ExecEmail] = ::User.get_superior_email(session[:user_email])
      end
    elsif (job[:Status]=="Submitted to EX")
      job[:Status]="Completed"
    end

    if(params[:cancel]=="true")
      job[:Status]="Cancelled"
    end
    job.permit!
    job_update = ::Job.update(job)
    redirect_to(job_path(id: job_update[:data][:JobNumber]))
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def edit_job_params
    params.permit(:FirstName, :JobNumber, :PhoneNumber, :BestTimeToCall, :Partnership, :Status, :Address, :JobDescription, :Comment, :S, :M, :L, :XL, :XXL, 'Parking Pass Required', 'Completable in Rain', 'All tools provided', 'Ordering T-Shirts', 'PaintGallons Needed', 'PaintGallons Provided', 'PaintBrushes Provided', 'PaintBrushes Needed', 'PaintRollers Provided', 'PaintRollers Needed', 'PaintScrapers Provided', 'PaintScrapers Needed', 'PaintTrays Provided', 'PaintTrays Needed', 'RollerExtensions Provided', 'RollerExtensions Needed', 'Ladders Provided', 'Ladders Needed', 'DropCloths Provided', 'DropCloths Needed', 'TrashBags Provided', 'TrashBags Needed', 'Mops Provided', 'Mops Needed', 'Brooms Provided', 'Brooms Needed', 'DustPans Provided', 'DustPans Needed', 'PaperTowels Provided', 'PaperTowels Needed', 'ScouringPads Provided', 'ScouringPads Needed', 'GardenSpades Provided', 'GardenSpades Needed', 'HandClippers Provided', 'HandClippers Needed', 'Hammers Provided', 'Hammers Needed', 'Saws Provided', 'Saws Needed', 'HardRakes Provided', 'HardRakes Needed', 'LeafRakes Provided', 'LeafRakes Needed', 'Hoes Provided', 'Hoes Needed', 'HedgeShears Provided', 'HedgeShears Needed', 'SpadeShovels Provided', 'SpadeShovels Needed', 'FlatShovels Provided', 'FlatShovels Needed', 'TrenchingShovels Provided', 'TrenchingShovels Needed', 'TreeTrimmers Provided', 'TreeTrimmers Needed', 'Axes Provided', 'Axes Needed', 'Gloves Provided', 'Gloves Needed')
  end

  def check_login
    if(!session[:user_email].present?)
      flash[:notice] = "User not signed in"
      redirect_to root_path
    end
  end

  def access_control(current_status, user_level, user_email, committee_email="", exec_email="")
    button_value=""
    cancel=false
    access_given=false

    if(current_status == "Not Completed")
      button_value = "Schedule Job Check"
      if(user_level=="SA")
        access_given=true
      end
    elsif(current_status == "Job Check Scheduled")
      button_value = "Complete Job Check"
      if(user_level=="SA")
        access_given=true
      end
    elsif(current_status == "Completed by SA")
      button_value = "Submit to CM"
      if(user_level=="SA")
        access_given=true
      end
    elsif(current_status == "Submitted to CM")
      button_value = "Submit to EX"
      if(user_level=="CM" && user_email==committee_email)
        access_given = true
      end
    elsif(current_status == "Completed")
      button_value = "Complete"
    else
      button_value = "NA"
      access_given = false
    end
    if(user_level=="EX")
      cancel=true
      access_given = true
    end
    [button_value, access_given, cancel]
  end


end
