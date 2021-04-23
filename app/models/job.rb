require './app/models/base.rb'

class Job < Base
    # READ FROM A COLLECTION AND DOCUMENT

    def self.show(jobs_id)
        query = db_ref.where "JobNumber", "=", "#{jobs_id}"
        
        {}.tap do |hash|
            query.get do |job|
              hash[:data] = job.data
            end
        end
    end
    
    def self.update(job_params)
        job_ref = db_ref.doc "#{job_params[:JobNumber]}"
        
        job_params.each do |key, val|
            job_ref.update({ "#{key}": "#{val}" })
        end
        
        show(job_params[:JobNumber])
    end

    def self.jobs_for_partnership(partnership)
        query = db_ref.where "Partnership", "=", "#{partnership}"
        job_list = []
        query.get do |job|
            job_list << job.data
        end
        job_list   #array of hashes
    end

    def self.all_partnerships()
        all_partnerships = (db_ref.get().map  { |x| x[:Partnership] }).compact.uniq
    end

    def self.partnership_for_user(user)
        query = db_ref.where "CommitteeEmail", "=", "#{user}"
        query.get do |job|
            return job.data[:Partnership]
        end
    end

    def self.all_status()
        all_status = db_ref.get().map  { |x| x[:Status] }
    end

    private
    
    attr_accessor :doc_ref
    
    def self.db_ref()
        @doc_ref ||= db_object.col "jobs_2021"
    end
end
