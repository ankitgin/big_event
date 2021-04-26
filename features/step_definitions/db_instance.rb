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
            project_id: 'the-big-event-online',
            credentials: @cred
        )
    end
end
