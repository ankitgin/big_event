Given /the following jobs exist/ do |jobs_table|
  jobs_table.hashes.each do |job|
    JobDb.create(job)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # fail "Unimplemented"
end

Then /(.*) seed jobs should exist/ do | n_seeds |
  JobDb.count.should be n_seeds.to_i
end

When "I am on the HomePage" do
end

Then "I am on the HomePage testing" do
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(1==1)
end

When /I delete the jobs (.*)/ do |jobs|
  jobs = jobs.delete('\\"').split(',')  # removing backslash from the string and converting it into an array
  JobDb.delete(jobs)
end
