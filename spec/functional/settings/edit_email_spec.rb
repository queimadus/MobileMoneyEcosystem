require 'spec_helper'

feature "Edit Email" do
	Steps "Edit client email" do
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
			page.fill_in "user_email", :with => 'client@client.c'
		end
		And "I click Save" do
			page.click_button "save_email"
		end
		Then "I should see success message" do
			page.should have_content "Email updated"
		end
		And "I should reset default e-mail" do 
			page.fill_in "user_email", :with => 'c@c.c'
			page.click_button "save_email"
			page.should have_content "Email updated"
		end
	end
	Steps "Edit merchant email" do
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
		When "I go to credits page" do
			page.visit "/settings"
		end
		And "I fill in fisrt name" do
			page.fill_in "user_email", :with => 'merchant@merchant.m'
		end
		And "I click Save" do
			page.click_button "save_email"
		end
		Then "I should see success message" do
			page.should have_content "Email updated"
		end
		And "I should reset default e-mail" do 
			page.fill_in "user_email", :with => 'm@m.m'
			page.click_button "save_email"
			page.should have_content "Email updated"
		end
	end
end