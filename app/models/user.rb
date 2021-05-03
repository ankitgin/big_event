require './app/models/base.rb'

class User < Base
    extend CarrierWave::Mount
    mount_uploader :csv, CsvUploader
    
    attr_accessor :email, :first_name, :last_name, :level, :uin, :partnership_number, :superior_email, :committee

    def initialize(user_doc)
        if !User.staff_member?(user_doc)
            @email = ""
            @first_name = ""
            @last_name = ""
            @level = ""
            @partnership_number = ""
            @committee = ""
            @superior_email = ""
            @uin = ""
        else 
            @email = user_doc[:email]
            @first_name = user_doc[:firstname]
            @last_name = user_doc[:lastname]
            @level = user_doc[:level]
            @partnership_number = user_doc[:partnershipnumber]
            @committee = user_doc[:committee]
            @superior_email = user_doc[:superioremail]
            @uin = user_doc[:uin]
        end
    end

    def self.staff_member?(user_doc)
        return user_doc.exists?
    end

    def self.executive?(user_doc)
        return user_doc[:level] == "EX"
    end

    def self.get(email)
       db_ref_staff.doc(email).get
    end

    def save
        self.store_csv!
    end

    def save_in_db(user_doc)
        user_data = {
            email: @email,
            firstname: @first_name,
            lastname: @last_name,
            uin: @uin,
            level: @level,
            partnershipnumber: @partnership,
            committee: @committee,
            superioremail: @superior_email
        }
        user_doc.set(user_data)
    end

    def self.all
        @users = []
        db_ref_staff.get do |user|
            @users << User.new(user)
        end
        @users
    end

    def self.update_from_csv(csv_attachment)
        user_table = CSV.parse(csv_attachment.tempfile.open, :headers => true, :header_converters => :symbol)
        headers = user_table.headers
        db_object.batch do |b|
            user_table.each do |user|
                user_entry = {}
                id = ""
                user.each do |field|
                    if field[0] == :email
                        id = field[1]
                    end
                    user_entry[field[0]]= field[1]
                end
                if !id.nil?
                    b.set(Rails.configuration.user_col + "/" + id, user_entry)
                end
            end 
        end
    end

    def self.to_csv
        attributes = %w{email firstname lastname level uin partnershipnumber superioremail committee}

        CSV.generate(headers: true) do |csv|
            csv << attributes
            self.all.each do |user|
                csv << [user.email, user.first_name, user.last_name, user.level, user.uin, user.partnership_number, user.superior_email, user.committee]
            end
        end
    end

    def self.valid_csv?(csv_attachment)
        return csv_attachment.present? && User.original_content_type(csv_attachment.original_filename).in?(%w(.csv .xlsx))
    end

    private
        attr_accessor :doc_ref_staff
        def self.db_ref_staff()
            @doc_ref_staff ||= db_object.col Rails.configuration.user_col
        end

        def self.original_content_type(original_filename)
            content_type = ""
            period_index = original_filename.rindex(".")
            if !period_index.nil?
                content_type = original_filename[period_index..]
            end
            content_type
        end

end
