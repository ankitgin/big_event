require './features/step_definitions/db_instance.rb'

class UserDb < Base
    def self.create(user_params)
        user_ref = db_ref_staff.doc "#{user_params[:email]}"
        user_ref.set(user_params)
        
        #show(user_params[:email])
    end
    
    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col "staff"
        end
end