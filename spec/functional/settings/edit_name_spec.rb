require 'spec_helper'

feature "Edit Name" do
	Steps "Edit client name" do
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
		And "I fill in fisrt name" do
			page.fill_in "client_first_name", :with => 'Joao'
		end
		And "I fill in last name" do
			page.fill_in "client_last_name", :with => 'Santos'
		end
		And "I click Save" do
			page.click_button "save_name"
		end
		Then "I should see success message" do
			page.should have_content "Name updated"
		end
		And "I should see my name on page" do
			page.should have_content "Joao Santos"
		end
	end
end