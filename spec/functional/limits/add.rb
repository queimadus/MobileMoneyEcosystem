require 'spec_helper'

feature "Add limit" do
	Steps "Add a new limit to user account" do
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
		When "I go to limits page" do
			page.visit "/limits"
		end
		And "I click on new limit button" do
			page.click_link_or_button "newlimit"
		end
		And "I select category" do
			page.select "Vegetais", :from => 'limit_category_id'
		end
		And "I fill in maximum value to limit" do
			page.fill_in "limit_max", :with => "100"
		end
		And "I select limit period 'MONTHLY'" do
			page.select "MONTHLY", :from => 'limit_period'
		end
		And "I click on create" do
			page.click_button "Create"
		end
		Then "I should see my created limit" do
			page.should have_content "VEGETAIS"
		end
	end
end