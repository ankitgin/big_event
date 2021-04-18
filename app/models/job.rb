require './app/models/base.rb'

class Job < Base
    # READ FROM A COLLECTION AND DOCUMENT
    def self.show(jobs_id) 
        doc_ref  = db_object.col "jobs_2021"
        query = doc_ref.where "JobNumber", "=", "#{jobs_id}"
        
        {}.tap do |hash|
            query.get do |city|
              hash[:data] = city.data
            end
        end
    end
end
