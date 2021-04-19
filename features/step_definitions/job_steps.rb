Given /the following jobs exist/ do |jobs_table|
  jobs_table.hashes.each do |job|
      debugger
    ::Job.insert(job)
  end
end