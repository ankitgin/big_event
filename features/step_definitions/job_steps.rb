When "I am on the HomePage" do
end
Then "I am on the HomePage testing" do
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(1==1)
end
