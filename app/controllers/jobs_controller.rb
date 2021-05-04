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
    job[:Status]="Job Check Scheduled" if (job[:Status]=="Not Completed")
    job[:Status]="Completed by SA" if (job[:Status]=="Job Check Scheduled")
    job[:Status]="Completed" if (job[:Status]=="Submitted to EX")
    
    if (job[:Status]=="Completed by SA")
      job[:Status]="Submitted to CM"
      if(session[:user_email].present?)
        job[:CommitteeEmail] = ::User.get_superior_email(session[:user_email])
      end
    elsif (job[:Status]=="Submitted to CM")
      job[:Status]="Submitted to EX"
      if(session[:user_email].present?)
        job[:ExecEmail] = ::User.get_superior_email(session[:user_email])
      end
    end
    
    job[:Status]="Cancelled" if(params[:cancel]=="true")
    
    job.permit!
    job = ::Job.update(job)
    redirect_to(job_path(id: job[:data][:JobNumber]))
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def edit_job_params
    params.permit(:FirstName, :JobNumber, :PhoneNumber, :BestTimeToCall, :Partnership, :Status, :Address, :JobDescription, 
    :Comment, :S, :M, :L, :XL, :XXL, 'Parking Pass Required', 'Completable in Rain', 'All tools provided', 'Ordering T-Shirts', 
    'PaintGallons Needed', 'PaintGallons Provided', 'PaintBrushes Provided', 'PaintBrushes Needed', 'PaintRollers Provided', 
    'PaintRollers Needed', 'PaintScrapers Provided', 'PaintScrapers Needed', 'PaintTrays Provided', 'PaintTrays Needed', 
    'RollerExtensions Provided', 'RollerExtensions Needed', 'Ladders Provided', 'Ladders Needed', 'DropCloths Provided', 
    'DropCloths Needed', 'TrashBags Provided', 'TrashBags Needed', 'Mops Provided', 'Mops Needed', 'Brooms Provided', 'Brooms Needed', 
    'DustPans Provided', 'DustPans Needed', 'PaperTowels Provided', 'PaperTowels Needed', 'ScouringPads Provided', 'ScouringPads Needed', 
    'GardenSpades Provided', 'GardenSpades Needed', 'HandClippers Provided', 'HandClippers Needed', 'Hammers Provided', 'Hammers Needed', 
    'Saws Provided', 'Saws Needed', 'HardRakes Provided', 'HardRakes Needed', 'LeafRakes Provided', 'LeafRakes Needed', 'Hoes Provided', 
    'Hoes Needed', 'HedgeShears Provided', 'HedgeShears Needed', 'SpadeShovels Provided', 'SpadeShovels Needed', 'FlatShovels Provided', 
    'FlatShovels Needed', 'TrenchingShovels Provided', 'TrenchingShovels Needed', 'TreeTrimmers Provided', 'TreeTrimmers Needed', 
    'Axes Provided', 'Axes Needed', 'Gloves Provided', 'Gloves Needed', 'Yard Sign', 'Years participated in The Big Event',
    'Recipient Biography', 'Is there a pet at the residence?', 'If yes, what type of pet?', 'Overall, is there a risk?',
    'If so, what is the risk?', 'Is this a media job?', 'Is Job Site Checklist complete?', 'Is Risk Eval Complete?', 
    'Is Recipient Biography complete?', 'Is Waiver/Indemnation Form Complete?', "Is Waiver/Indemnation Form Complete?",
    'Is job reviewed by exec?', 'Backup job?', 'See Solutions?', 'Is Checked In', 'Is Job Cancelled', 'Cancellation Date',
    'Cancellation Reason')
  end

  def check_login
    if(!session[:user_email].present?)
      flash[:notice] = "User not signed in"
      redirect_to root_path
    end
  end

  def access_control(current_status, user_level, user_email, committee_email="", exec_email="")
    cancel=false
    access_given=false

    access_given=true if(current_status == "Not Completed" && user_level=="SA")
    access_given=true if(current_status == "Job Check Scheduled" && user_level=="SA")
    access_given=true if(current_status == "Completed by SA" && user_level=="SA")
    access_given = true if(current_status == "Submitted to CM" && user_level=="CM" && user_email==committee_email)
    access_given = true if(current_status == "Submitted to EX" && user_level=="EX" && user_email==exec_email)
  
    if(user_level=="EX")
      cancel=true
      access_given = true
    end
    
    [button_value(current_status), access_given, cancel]
  end
  
  def button_value(current_status)
    return "Schedule Job Check" if(current_status == "Not Completed") 
    return "Complete Job Check" if(current_status == "Job Check Scheduled")
    return "Submit to CM" if(current_status == "Completed by SA")
    return "Submit to EX" if(current_status == "Submitted to CM")
    return "Complete" if(current_status == "Submitted to EX")
    "NA"
  end

end
