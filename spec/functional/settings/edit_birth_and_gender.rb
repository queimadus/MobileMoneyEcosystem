require 'spec_helper'

feature "Edit Birth And Gender" do
	Steps "Edit birth and gender of client" do
		When "I go to login page" do
			page.visit "/login"
		end
		And "I fill in right email" do
			page.fill_in "user_email", :with => "c@c.c"
		end
		And "I fill in  right password" do
			page.fill_in "user_password", :with => "bbbbbbbb"
		end
		And "I click sign in" do
			page.click_button "Sign in"
		end
		When "I go to settings page" do
			page.visit "/settings"
		end
		And "I select day of birth" do
			page.select "23", :from => 'client_dob_3i'
		end
		And "I select month of birth" do
			page.select "March", :from => 'client_dob_2i'
		end
		And "I select year of birth" do
			page.select "1987", :from => 'client_dob_1i'
		end
		And "I select gender" do
			page.select "Female", :from => 'client_sex'
		end
		And "I click Save" do
			page.click_button "save_extra_info"
		end
		Then "I should see success message" do
			page.should have_content "Info updated"
		end
	end
end