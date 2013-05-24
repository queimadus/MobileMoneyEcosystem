require 'spec_helper'

feature "Credit Account product" do
	Steps "Increase my account credit correctly" do
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
		When "I go to credits page" do
			page.visit "/credits"
		end
		And "I fill in amount" do
			page.fill_in "amount", :with => '1000'
		end
		And "I fill in card number" do
			page.fill_in "number", :with => '4111111111111111'
		end
		And "I fill in CVV" do
			page.fill_in "cvv", :with => '123'
		end
		And "I fill in month of expiration" do
			page.fill_in "month", :with => '01'
		end	
		And "I fill in year of expiration" do
			page.fill_in "year", :with => '2014'
		end
		And "I click Credit" do
		end
		Then "I should see my account credit increased" do
			page.should have_content "1000.0"
		end
	end
end