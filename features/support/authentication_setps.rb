Given /^a user with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  user = User.create(:email => email, :password => password,
                     :password_confirmation => password)
  user.save!
end

When /^I sign in manually as "([^"]*)" with password "([^"]*)"$/ do |email, password|
  @me = User.find_by_email(email)
  @me.password ||= password
  #manual_login
  #confirm_login
end

Then /^I should be able to (.*)$/ do |action|
  #agent.page.body.include?(action)
end

#---------------------------------------------------------------

Given /^I am an authenticated user$/ do
  email = 'm@m.m'
  password = 'bbbbbbbb'

  step "I have one user with email #{email} and password #{password}"
  step "I go to the user login page"
  step "I fill in email_field with #{email}"
  step "I fill in password_field with #{password}"
  step "I press Sign In"
end

Given /^I have one user with email (.*) and password (.*)$/ do |email, password|
  #TODO
end

Given /^I go to the usr login page$/ do
  #TODO
end

Given /^I fill in email_field with (.*)$/ do |email|
  #TODO
end

Given /^I fill in password_field with (.*)$/ do |password|
  #TODO
end

Given /^I press Sign In$/ do |email|
  #TODO
end

#------------------------------------