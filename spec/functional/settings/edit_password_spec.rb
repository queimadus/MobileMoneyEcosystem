require 'spec_helper'

feature "Edit Password" do
	Steps "Edit client password" do
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
		And "I fill in new password" do
			page.fill_in "user_password", :with => "12345678"
		end
		And "I fill in confirm new password" do
			page.fill_in "user_password_confirmation", :with => "12345678"
		end
		And "I fill in current password" do
			page.fill_in "user_current_password", :with => "bbbbbbbb"
		end
		And "I click Save" do
			page.click_button "save_password"
		end
		Then "I should see success message" do
			page.should have_content "You updated your account successfully"
		end
		Then "I should logout" do 
			page.visit "/logout"
		end
		And "Then login with new password" do
			page.visit "/login"
			page.fill_in "user_email", :with => "c@c.c"
			page.fill_in "user_password", :with => "12345678"
			page.click_button "Sign in"
		end
		And "I should set my default password" do
			page.visit "/settings"
			page.fill_in "user_password", :with => "bbbbbbbb"
			page.fill_in "user_password_confirmation", :with => "bbbbbbbb"
			page.fill_in "user_current_password", :with => "12345678"
			page.click_button "save_password"
			page.should have_content "You updated your account successfully"
		end
	end
	Steps "Edit merchant password" do
		When "I go to login page" do
			page.visit "/login"
		end
		And "I fill in right email" do
			page.fill_in "user_email", :with => "m@m.m"
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
		And "I fill in new password" do
			page.fill_in "user_password", :with => "12345678"
		end
		And "I fill in confirm new password" do
			page.fill_in "user_password_confirmation", :with => "12345678"
		end
		And "I fill in current password" do
			page.fill_in "user_current_password", :with => "bbbbbbbb"
		end
		And "I click Save" do
			page.click_button "save_password"
		end
		Then "I should see success message" do
			page.should have_content "You updated your account successfully"
		end
		Then "I should logout" do 
			page.visit "/logout"
		end
		And "Then login with new password" do
			page.visit "/login"
			page.fill_in "user_email", :with => "m@m.m"
			page.fill_in "user_password", :with => "12345678"
			page.click_button "Sign in"
		end
		And "I should set my default password" do
			page.visit "/settings"
			page.fill_in "user_password", :with => "bbbbbbbb"
			page.fill_in "user_password_confirmation", :with => "bbbbbbbb"
			page.fill_in "user_current_password", :with => "12345678"
			page.click_button "save_password"
			page.should have_content "You updated your account successfully"
		end
	end
end