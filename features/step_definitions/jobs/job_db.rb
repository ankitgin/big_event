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
    
    # def self.delete(jobs)
    #     db_ref.get do |jobs|
    #         job_ref = db_ref.doc "#{jobs.document_id}"
    #         job_ref.delete
    #     end
    # end
    
    def self.count
        db_ref.get().count
    end
    
    private
    
    attr_accessor :doc_ref
    
    def self.db_ref()
        @doc_ref ||= db_object.col "jobs_2021"
    end
end
