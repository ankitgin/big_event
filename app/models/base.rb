require 'google/cloud/firestore'

class Base
    def self.db_object
        @cred ||= Google::Cloud::Firestore::Credentials.new('./key.json')
        
        @db ||= Google::Cloud::Firestore.new(
            project_id: 'the-big-event-online',
            credentials: @cred
        )
    end
end

# SAMPLE

# WRITE A 'test' DOCUMENT INSIDE THE 'jobs_2021' COLLECTION
# db.doc("jobs_2021/test").set({ name: "yay it worked!"})


# READ FROM A COLLECTION AND DOCUMENT
# doc_ref  = db.col "jobs_2021" 
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
