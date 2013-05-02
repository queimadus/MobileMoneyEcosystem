require 'spec_helper'

feature "Merchant search" do
	Steps "Merchant searches a product on his inventory" do
		When "I go to products page" do
			page.visit "/products"
		end
		And "I fill in search box with 'cenoura'" do
			page.fill_in "search", :with => "cenoura"
		end
		And "I click on serch button" do
			page.click_button "icon-button"
		end
		Then "I should see 'cenoura' description" do
			page.should have_content("Cenoura Golden")
		end
		And "I should see category 'Vegetais'" do
			page.should have_content("Vegetais")
		end
	end
end