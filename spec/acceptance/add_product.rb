require 'spec_helper'
include Warden::Test::Helpers

feature "Add product" do
	before(:each) do
		@u = User.new(:email => "m@m.m", :password => "bbbbbbbb")
		@m = Merchant.new(:name => "Bruno")
		@m.user = @u
		login_as @m, :scope => :user
	end
	Steps "Add a product correctly" do
		When "I go to products page" do
			page.visit "/products"
		end
		And "I should be on products page " do
			page.should have_content("Cenoura")
		end
		And "I click Add Product" do
			page.click_on "newproduct"
		end
		And "I fill in product name" do
			page.fill_in "product_name", :with => 'TestProduct'
		end
		And "I select category" do
			page.select "Assados", :from => 'category_id'
		end
		And "I fill in product brande" do
			page.fill_in "product_brand", :with => 'TestBrand'
		end
		And "I fill in product price" do
			page.fill_in "product_price", :with => '10.0'
		end
		And "I fill in product stock" do
			page.fill_in "product_stock", :with => 'TestLast'
		end
		
		#TODO: Missing image test
		
		And "I fill in product reference" do
			page.fill_in "product_reference", :with => 'TestReference'
		end
		And "I click create" do
			page.click_button "product-submit"
		end
		The "Page should be /products" do
			page.should have_content("/products")
		end
		And "I should see product reference " do
			page.should have_content("TestReference")
		end
	end
	Steps "Click on cancel add product" do
		When "I go to products page" do
			page.visit "/products"
		end
		And "I click Add Product" do
			page.click_on "newproduct"
		end
		And "I click cancel" do
			page.click_button "product-cancel"
		end
		The "Page should be /products" do
			page.should have_content("/products")
		end
	end
end