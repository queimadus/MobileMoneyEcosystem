require 'spec_helper'

feature "User signup" do
	background do
		@user = User.create(:email => 'm@m.m', :password => 'bbbbbbbb')
	end

	Steps "Signing in with correct credentials" do
		When "I go to sign up page" do
			page.visit "/login"
		end
		And "I fill in right email" do
			page.fill_in "user_email", :with => @user.email
		end
		And "I fill in  right password" do
			page.fill_in "user_password", :with => @user.password
		end
		And "I click sign in" do
			page.click_button "Sign in"
		end
		Then "I should see greeting" do
			page.should have_content("Signed in successfully")
		end
	end

	Steps "User tries to sign in with incorrect password" do
		When "I go to sign in page" do
			page.visit "/login"
		end
		And "I fill in right email" do
			page.fill_in "user_email", :with => @user.email
		end
		And "I fill in wrong password" do
			page.fill_in "user_password", :with => "anythingWrong"
		end
		And "I click sign in" do
			page.click_button "Sign in"
		end
		Then "I should see error" do
			page.should have_content("Invalid email or password")
		end
	end
end