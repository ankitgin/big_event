require './app/models/base.rb'

class Job < Base
    # READ FROM A COLLECTION AND DOCUMENT

    def self.show(jobs_id)
        query = db_ref.where "JobNumber", "=", "#{jobs_id}"
        
        {}.tap do |hash|
            query.get do |city|
              hash[:data] = city.data
            end
        end
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
        all_partnerships = db_ref.get().map  { |x| x[:Partnership] }
    end

    private
        attr_accessor :doc_ref
        def self.db_ref()
            @doc_ref ||= db_object.col "jobs_2021"
        end
end
