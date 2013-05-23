require 'spec_helper'

feature "Search market" do
	@merchant = 'Bruno'
	Steps "Unregistered user access market page of a merchant" do
		When "I go to a merchant page" do
			page.visit "/market/" + @merchant
		end
		Then "I should see some products added by that merchant" do
			page.should have_content("Papel higienico")
			page.should have_content("Tomate")
			page.should have_content("Frango Assado")
			page.should have_content("Alface")
		end
	end
	Steps "Unregistered user search a single product on market page of a merchant" do
		When "I go to a merchant page" do
			page.visit "/market/Bruno"
		end
		And "I fill in search box with desired search" do
			page.fill_in "search", :with => 'Cotonetes'
		end
		And "I click search" do
			page.click_button "icon-button"
		end
		Then "I should see searched item with its atributes" do
			page.should have_content("HIGIENE")
			page.should have_content("Cotonetes")
			page.should have_content("1.9")
		end
		And "Not see other category items" do
			page.should have_no_content("VEGETAIS")
			page.should have_no_content("ASSADOS")
			page.should have_no_content("HIGIENE")
		end
	end
	Steps "Unregistered user search multiple products on market page of a merchant" do
		When "I go to a merchant page" do
			page.visit "/market/Bruno"
		end
		And "I fill in search box with desired search" do
			page.fill_in "search", :with => 'Vegetais'
		end
		And "I click search" do
			page.click_button "icon-button"
		end
		Then "I should see various products with its atributes" do
			page.should have_content("Tomate")
			page.should have_content("Alface")
			page.should have_content("Cebola")
			page.should have_content("Broculos")
			page.should have_content("Pimento")
			page.should have_content("Maca")
			page.should have_content("Pepino")
		end
		And "Not see other category items" do
			page.should have_no_content("ASSADOS")
			page.should have_no_content("HIGIENE")
		end
	end
end