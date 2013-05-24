require 'spec_helper'

feature "Edit product" do
	Steps "Edit a product correctly" do
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
		And "I edit product name" do
			page.fill_in "product_name", :with => "TestProduct2"
		end
		And "I click on edit" do
			page.click_link_or_button "product-submit"
		end
		And "I return to products page" do
			page.visit "/products"
		end
		Then "Product should have its name changed" do
			page.should have_content("TestProduct2")
		end
	end
end