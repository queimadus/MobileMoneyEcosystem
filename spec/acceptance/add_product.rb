require 'spec_helper'

feature "Add product" do
	Steps "Add a product correctly" do
		When "I go to sign in page" do
			page.visit "/products"
		end
		And "I click 'Add new product'" do
			page.find("btn btn-primary btn-large").click
		end
	end
end