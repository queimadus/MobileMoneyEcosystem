require 'spec_helper'

feature "Remove limit" do
	Steps "Delete a limit to user account" do
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
		And "I click on edit limit button" do
			page.find("#edit_button").click
		end
		And "I shouldnt see Vegetais limit created" do
			page.should have_no_content "Vegetais"
		end
		And "I click on delete limit button" do
			page.find(".del").click
		end
	end
end