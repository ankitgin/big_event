Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      UserDb.create(user)
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
    end
    # fail "Unimplemented"
  end


  When /^(?:|I )press "([^"]*)"$/ do |button|
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
  
  Given('I am an Executive') do
    # controller.session[:level] = 'EX'
    # FIX ME: need to give user access to staff directory by setting level to 'EX' in session
  end
  
  When('I am on the users page') do
    visit users_path
  end

  Then /^I should see all (.*)$/ do |content_type|
    # FIX ME: Currently does not run because can not gain access to staff directory page
    # rows = page.all('#users tbody tr').size
    # expect(rows).to eq UserDb.count
  end
