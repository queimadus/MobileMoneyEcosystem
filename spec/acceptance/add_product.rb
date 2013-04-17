require 'spec_helper'

feature "Add product" do
	Steps "Add a product correctly" do
		When "I go to sign in page" do
			page.visit "/products/new"
		end
	end
end