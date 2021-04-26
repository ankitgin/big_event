require './features/step_definitions/db_instance.rb'

class JobDb < Base
    def self.show(jobs_id)
        query = db_ref.where "JobNumber", "=", "#{jobs_id}"
        
        {}.tap do |hash|
            query.get do |job|
              hash[:data] = job.data
            end
        end
    end
    
    def self.create(job_params)
        job_ref = db_ref.doc "#{job_params[:JobNumber]}"
        job_ref.set(job_params)
        
        show(job_params[:JobNumber])
    end
    
    def self.delete(job)
        job_ref = db_ref.doc "#{job}"
        job_ref.delete
    end
    
    def self.jobs_count(jobs)
        db_jobs = []
        
        jobs.each do |job|
            job_ref = db_ref.doc "#{job}"
            db_jobs.append(job_ref.get.data) if job_ref.get.data.present?
        end
        
        db_jobs.size
    end
    
    def self.count
        db_ref.get().count
    end
    
    private
    
    attr_accessor :doc_ref
    
    def self.db_ref()
        @doc_ref ||= db_object.col "jobs_2021"
    end
end
