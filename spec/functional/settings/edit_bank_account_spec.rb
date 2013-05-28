require 'spec_helper'

feature "Edit Bank Account" do
	Steps "Edit merchant bamk account number" do
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
		And "I fill in bank account number" do
			page.fill_in "merchant_bank_account", :with => '123456789012345'
		end
		And "I click Save" do
			page.click_button "save_bank_account"
		end
		Then "I should see success message" do
			page.should have_content "Bank account updated"
		end
	end
end