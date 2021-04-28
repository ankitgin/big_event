Given /the following users exist/ do |users_table|
    UserDb.clean(users_table)
    users_table.hashes.each do |user|
      UserDb.create(user)
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
    end
  end


  When /^I press "(.*)"$/ do |button|
    click_link button
  end
  
  Then /^(?:|I )should be on (.+)$/ do |page_name|
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == path_to(page_name)
    else
      assert_equal path_to(page_name), current_path
    end
  end
  
  When /^the authentication page/ do
    redirect_to '/auth/google_oauth2'
  end
  
  When('I have a valid email') do
    
  end
  
  Then('I am logged in') do
    pending # Write code here that turns the phrase above into concrete actions
  end

  Given /^I am logged in as '(.*)'$/ do |user_email|
    visit 'auth/:provider/callback'
  end
  
  When('I am on the users page') do
    visit users_path
  end

  # And /^I am an '(.*)'$/ do |level|
  #   expect(ApplicationHelper.level).to eq level
  # end

  Then /^I should see all (.*)$/ do |content_type|
    # FIX ME: Currently does not run because can not gain access to staff directory page
    rows = page.all('#users tbody tr').size
    expect(rows).to eq UserDb.count
  end

  And /^I upload '(.*)'$/ do |file_name|
    attach_file(:csv_file, File.join(Rails.root, 'features', 'test-files', file_name))
    click_button "Upload CSV"
  end

  Then /^I should see '(.*)' on the users page$/ do |email|
    page.has_content?(email)
  end

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