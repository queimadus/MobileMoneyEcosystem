require 'spec_helper'
include Warden::Test::Helpers

feature "Remove product" do
	before(:each) do
		@u = User.new(:email => "m@m.m", :password => "bbbbbbbb")
		@m = Merchant.new(:name => "Bruno")
		@m.user = @u
		login_as @m, :scope => :user
	end
	Steps "Remove a product correctly" do
		When "I go to products page" do
			page.visit "/products"
		end
		And "I click edit product" do
			page.click_link "/products/64/edit"
		end
		And "I click delete" do
			page.click_link "/products/64"
		end
		Then "Page should no have product link" do
			page.should_not have_content("/products/64")
		end
	end
end