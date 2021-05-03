Given /the following users exist/ do |users_table|
    UserDb.clean(users_table)
    users_table.hashes.each do |user|
      UserDb.create(user)
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
    end
  end

  Given /^the staff member, "(.*)", is removed from the directory$/ do |email|
    UserDb.remove(email)
  end

  Given /^I, "(.*)", am an "(.*)" level$/ do |email, level|
    UserDb.set_level(email, level)
  end

  When /^I log in as "(.*)"$/ do |user_email|
    visit 'auth/:provider/callback'
  end

  Given /^I am logged in as "(.*)"$/ do |user_email|
    visit 'auth/:provider/callback'
  end
  
  # When('I am on the users page') do
  #   visit users_path
  # end

  # And /^I am an '(.*)'$/ do |level|
  #   expect(ApplicationHelper.level).to eq level
  # end

  Then /^I should see all users$/ do 
    # FIX ME: Currently does not run because can not gain access to staff directory page
    rows = page.all('#users tbody tr').size
    expect(rows).to eq UserDb.count
  end

  And /^I upload '(.*)'$/ do |file_name|
    attach_file(:csv_file, File.join(Rails.root, 'features', 'test-files', file_name))
    click_button "Upload CSV"
  end

  # Then /^I should see '(.*)' on the users page$/ do |email|
  #   page.has_content?(email)
  # end

  Then /^I should receive the csv file: '(.*)'$/ do |file_name| 
    page.response_headers['Content-Disposition'].should include("filename=\"#{file_name}\"")
  end

  Given /^the exported file, '(.*)', exists$/ do |file_name|
    file_path = File.join(Rails.root, 'features', 'test-files', file_name)
    File.exist?(file_path)
  end

  Then /^'(.*)' should contain the database information$/ do |file_name|
    file_path = File.join(Rails.root, 'features', 'test-files', file_name)
    user_table = CSV.parse(File.read(file_path),:headers => :true, :header_converters => :symbol)
    valid = true
    user_table.each do |user|
      db_user = UserDb.get(user[0])
      if !db_user.exists? || db_user[:level] != user[1]
        valid = false
        break
      end
    end
    valid
  end