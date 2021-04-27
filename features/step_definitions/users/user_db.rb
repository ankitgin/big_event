require './features/step_definitions/db_instance.rb'

class UserDb < Base
    def self.create(user_params)
        user_ref = db_ref_staff.doc "#{user_params[:email]}"
        user_ref.set(user_params)
        
        #show(user_params[:email])

    end

    def initialize(user_doc)
        @email = user_doc[:email]
        @level = user_doc[:level]
    end

    def self.all
        @users = []
        db_ref_staff.get do |user|
            @users << UserDb.new(user)
        end
        @users
    end
    
    def self.count
        count = 0
        db_ref_staff.get do |user|
            count += 1
        end
        count
    end

    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col Rails.configuration.user_col
        end
end