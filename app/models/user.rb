require './app/models/base.rb'

class User < Base
    attr_accessor :email, :name, :level, :uin, :partnership, :superior_email

    def initialize(user_doc)
        @email = user_doc[:Email]
        @name = user_doc[:Name]
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
            Name: @name,
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

    def self.update_from_csv(csv_file_path)
        user_table = CSV.parse(File.read(csv_file_path), :headers => true, :header_converters => :symbol)
        # email_index = user_table.find_index {|row| row[0] == :email}
        # headers = user_table.headers
        # email_index = headers.find(:email)

        # puts "email index"
        # puts email_index
        db_object.batch do |b|
            puts "2"
            user_table.each do |user|
                user_entry = {}
                id = ""
                user.each do |field|
                    if field[0] == :email
                        id = field[1]
                    end
                    user_entry[field[0]]= field[1]
                end
                puts "staff/"+id
                b.set("staff/"+id, user_entry)
                puts "NEW USER ENTRY"
                puts user_entry
            end 
            puts "3"
        end
        puts "4"
    end

    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col "staff"
        end
        
end