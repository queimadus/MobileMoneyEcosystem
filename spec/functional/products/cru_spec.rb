require 'spec_helper'

RSpec.configure do |config|
	config.order_groups_and_examples do |list|
		list.sort_by { |item| item.description }
	end
end
feature "Create Update and Remove product" do

	Steps "Add a product correctly" do
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
			page.visit "/products/new"
		end
		And "I fill in product name" do
			page.fill_in "product_name", :with => 'TestProduct'
		end
		And "I select category" do
			page.select "Higiene", :from => 'category_id'
		end
		And "I fill in product brande" do
			page.fill_in "product_brand", :with => 'TestBrand'
		end
		And "I fill in product price" do
			page.fill_in "product_price", :with => '9999.0'
		end
		And "I fill in product stock" do
			page.fill_in "product_stock", :with => '9999'
		end	
		And "I fill in product reference" do
			page.fill_in "product_reference", :with => 'TestReference'
		end
		And "I click create" do
			page.click_button "product-submit"
		end
		Then "I see created product" do
			page.should have_content("TestProduct")
		end
	end
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