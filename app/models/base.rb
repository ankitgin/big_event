require 'google/cloud/firestore'

class Base
    def self.db_object
        @cred ||= Google::Cloud::Firestore::Credentials.new('../../key.json')
        
        @db ||= Google::Cloud::Firestore.new(
            project_id: 'the-big-event-online',
            credentials: @cred
        )
    end
end