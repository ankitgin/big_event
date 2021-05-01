Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    UserDb.create(user)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # fail "Unimplemented"
end

When /^the authentication page/ do
  redirect_to '/auth/google_oauth2'
end

When('I have a valid email') do
  
end

Then('I am logged in') do
  pending # Write code here that turns the phrase above into concrete actions
end
