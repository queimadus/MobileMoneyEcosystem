require 'spec_helper'
include Warden::Test::Helpers

feature "Edit product" do
	before(:each) do
		@u = User.new(:email => "m@m.m", :password => "bbbbbbbb")
		@m = Merchant.new(:name => "Bruno")
		@m.user = @u
		login_as @m, :scope => :user
	end
	Steps "Edit a product correctly" do
		When "I go to products page" do
			page.visit "/products"
		end
		And "I should be on products page " do
			page.should have_content("Cenoura")
		end
		And "I click edit product" do
			page.click_link "/products/64/edit"
		end
		And "I fill in product name" do
			page.fill_in "product_name", :with => 'TestingEditProduct'
		end
		And "I click update" do
			page.click_button "product-submit"
		end
		Then "Page should be /products" do
			page.should have_content("/products")
		end
		And "I should see the edited product " do
			page.should have_content("TestingEditProduct")
		end
	end
end