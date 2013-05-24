require 'spec_helper'

feature "Client register" do
	Steps "Register a client" do
		When "I go to client register page" do
			page.visit "/register/client"
		end
		And "I fill in first name" do
			page.fill_in "client[first_name]", :with => 'TestFirst'
		end
		And "I fill in last name" do
			page.fill_in "client[last_name]", :with => 'TestLast'
		end
		And "I fill in desired email" do
			page.fill_in "user_email", :with => 'testclient@test.com'
		end
		And "I fill in desired password" do
			page.fill_in "user_password", :with => 'testtest'
		end
		And "I fill in password confirmation" do
			page.fill_in "user_password_confirmation", :with => 'testtest'
		end
		And "I select day of birth" do
			page.select "1", :from => 'client_dob_3i'
		end
		And "I select month of birth" do
			page.select "January", :from => 'client_dob_2i'
		end
		And "I select year of birth" do
			page.select "1991", :from => 'client_dob_1i'
		end
		And "I select gender" do
			page.select "Male", :from => 'sex_Gender'
		end
		And "I click register" do
			page.click_button "Register"
		end
		Then "I should see greeting" do
			page.should have_content("You have signed up successfully")
		end
	end
end