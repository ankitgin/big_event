require 'google/cloud/firestore'

class Base
    def self.db_object
        # @cred ||= Google::Cloud::Firestore::Credentials.new('./key.json')
        gcp = './key.json'
        if defined?ENV && defined?ENV["RAILS_ENV"]
            if (ENV["RAILS_ENV"] == "production")
                gcp = JSON.parse(ENV["gcp_key"])
            end
       end
       
        @cred ||= Google::Cloud::Firestore::Credentials.new(gcp)        
        
        @db ||= Google::Cloud::Firestore.new(
            project_id: 'fireapp-49269',
            credentials: @cred
        )
    end
end

# SAMPLE

# WRITE A 'test' DOCUMENT INSIDE THE 'jobs_2021' COLLECTION
# db.doc("jobs_2021/test").set({ name: "yay it worked!"})


# READ FROM A COLLECTION AND DOCUMENT
# doc_ref = db.col "jobs_2021" 
# query = doc_ref.where "City", "=", "College Station"

# query.get do |city|
#   puts "#{city.document_id} data: #{city.data}."
# end


# DELETE DOCUMENT
# doc_ref  = db.col "jobs_2021" 
# doc_ref.delete


# DELETE FIELDS
# doc_ref  = db.col "jobs_2021" 
# doc_ref.update({ capital: firestore.field_delete })

# DELETE COLLECTIONS
# col_ref = db.col "jobs_2021" 

# col_ref.get do |document_snapshot|
#   puts "Deleting document #{document_snapshot.document_id}."
#   document_ref = document_snapshot.ref
#   document_ref.delete
# end
# 
