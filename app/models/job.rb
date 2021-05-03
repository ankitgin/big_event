require './app/models/base.rb'

class Job < Base
    # READ FROM A COLLECTION AND DOCUMENT

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

    # def self.update_status(job)
    #     job_ref = db_jobs_2021.doc "#{job[:JobNumber]}"
    #     debugger
    #     job_ref.set(job)
    #     show(job[:JobNumber])
    # end

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

    def self.all_status()
        all_status = db_jobs_2021.get().map  { |x| x[:Status] }
    end
    
    def self.unique_status()
        all_status = db_job_statuses.get().map {|x| x.document_id }
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
