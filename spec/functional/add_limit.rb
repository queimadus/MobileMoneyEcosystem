require 'spec_helper'
include Warden::Test::Helpers

feature "Add limit" do
	before(:each) do
		u = User.new(:email => "m@m.m", :password => "bbbbbbbb")
		c = Client.new(:name => "Bruno")
		c.user = u
		login_as c, :scope => :user
	end
	Steps "Add a limit correctly" do
		When "I go to add new limit page" do
			page.visit "/limits/new"
		end
		And "I select category" do
			page.select "Assados", :from_client => 'limit_category_id'
		end
		And "I fill in limit value" do
			page.fill_in "limit_max", :with => '100'
		end
		And "I select periodicity" do
			page.select "MONTHLY", :from_client => 'limit_period'
		end
		And "I click create" do
			page.click_on "Create"
		end
		
		#TODO: Action after create limit
		
	end
	Steps "Click on cancel add limit" do
		When "I go to add new limit page" do
			page.visit "/limits/new"
		end
		And "I click cancel" do
			page.click_button "limit-cancel"
		end

		#TODO: Action after cancel add limit
		
	end
end