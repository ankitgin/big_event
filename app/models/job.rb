require './app/models/base.rb'

class Job < Base
    # READ FROM A COLLECTION AND DOCUMENT
    
    # can add more years for future
    def self.all_job_years
        %w(2018 2019 2020 2021)
    end

    def self.show(jobs_id)
        query = db_jobs_2021.where "JobNumber", "=", "#{jobs_id}"
        
        {}.tap do |hash|
            query.get do |job|
              hash[:data] = job.data
            end
        end
    end
    
    def self.update(job_params)
        job_ref = db_jobs_2021.doc "#{job_params[:JobNumber]}"
        job_ref.set(job_params.to_h)
        show(job_params[:JobNumber])
    end

    def self.jobs_for_partnership(partnership)
        query = db_jobs_2021.where "Partnership", "=", "#{partnership}"
        job_list = []
        query.get do |job|
            job_list << job.data
        end
        job_list   #array of hashes
    end

    def self.all_partnerships()
        all_partnerships = (db_jobs_2021.get().map  { |x| x[:Partnership] }).compact.uniq
    end

    def self.partnership_for_user(user)
        query = db_jobs_2021.where "CommitteeEmail", "=", "#{user}"
        query.get do |job|
            return job.data[:Partnership]
        end
    end

    def self.all_status()
        all_status = db_jobs_2021.get().map  { |x| x[:Status] }
    end
    
    def self.unique_status()
        all_status = db_job_statuses.get().map {|x| x.document_id }
    end
    
    def self.all_jobs_in_year(job_year)
        job_list = []
        #query = db_jobs_2021.where("JobNumber like ?", "#{job_year}")
        query = db_jobs_2021.where("JobYear", "=", "#{job_year}")
        query.get do |j|
            job_list << j.data
        end
        job_list
    end
    
    def self.to_csv_jobs(jobs)
        attributes = %w{JobNumber JobStatus Partnership Description}
        
        CSV.generate(headers: true) do |csv|
            csv << attributes
            jobs.each do |job|
                csv << [job[:JobNumber], job[:Status], job[:Partnership], job[:JobDescription]]
            end
        end
    end
    
    def self.update_from_csv(csv_attachment, job_year)
        user_table = CSV.parse(csv_attachment.tempfile.open, :headers => true, :header_converters => :symbol)
        db_object.batch do |b|
            user_table.each do |user|
                user_entry = {}
                id = ""
                user.each do |field|
                    if field[0] == :jobnumber
                        id = field[1]
                    end
                    user_entry[field[0]] = field[1]
                end
                if !id.nil?
                    b.set("jobs_"+ job_year + "/" + id, user_entry)
                end
            end 
        end
    end

    private
    
    attr_accessor :db_jobs_2021_ref, :db_job_statuses
    
    def self.db_jobs_2021()
        @db_jobs_2021_ref ||= db_object.col "jobs_2021"
    end
    
    def self.db_job_statuses()
        @db_job_statuses_ref ||= db_object.col "job_statuses"
    end
end
