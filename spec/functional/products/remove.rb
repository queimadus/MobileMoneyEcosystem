require 'spec_helper'

feature "Remove product" do
	Steps "Remove a product correctly" do
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
		When "I go to products page" do
			page.visit "/products/65/edit"
		end
		And "I click on delete" do
			page.click_link_or_button "delete-product"
		end
		And "I return to products page" do
			page.visit "/products"
		end
		Then "Product should not be on list" do
			page.should_not have_content("TestProduct")
		end
	end
end