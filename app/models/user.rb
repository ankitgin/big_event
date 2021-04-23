require './app/models/base.rb'

class User < Base
    attr_accessor :email, :first_name, :last_name, :level, :uin, :partnership, :superior_email

    def initialize(user_doc)
        @email = user_doc[:Email]
        @first_name = user_doc[:FirstName]
        @last_name = user_doc[:LastName]
        @level = user_doc[:Level]
        @partnership = user_doc[:PartnershipNumber]
        @superior_email = user_doc[:SuperiorEmail]
        @uin = user_doc[:UIN]
    end

    def self.staff_member?(user_doc)
        return user_doc.exists?
    end

    def self.from_omniauth(info)
        db_ref_staff.doc(info.email).get
    end

    def save(user_doc)
        user_data = {
            Email: @email,
            FirstName: @first_name,
            LastName: @last_name,
            Level: @level,
            PartnershipNumber: @partnership,
            SuperiorEmail: @superior_email,
            UIN: @uin
        }
        user_doc.set(user_data)
    end

    def self.all_users
        @users = []
        db_ref_staff.get do |user|
            @users << User.new(user)
        end
        @users
    end
    
    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col "staff"
        end
        
end