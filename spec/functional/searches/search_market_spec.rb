require 'spec_helper'

feature "Search market" do
	Steps "Unregistered user access market page of a merchant" do
		When "I go to a merchant page" do
			page.visit "/market/Bruno"
		end
		Then "I should see some products added by that merchant" do
			page.should have_content("Cenoura")
			page.should have_content("Papel higienico")
			page.should have_content("Tomate")
			page.should have_content("Frango Assado")
		end
	end
	Steps "Unregistered user search by product on market page of a merchant" do
		When "I go to a merchant page" do
			page.visit "/market/Bruno"
		end
		And "I fill in search box with desired search" do
			page.fill_in "search", :with => 'Cotonetes'
		end
		And "I click on search button" do
			page.click_button "search_button"
		end
		Then "I should see searched item with its atributes" do
			page.should have_content("Cotonetes")
			page.should have_content("1.9")
		end
		And "Not see other items" do
			page.should have_no_content("Frango Assado")
			page.should have_no_content("Tomate")
			page.should have_no_content("Alface")
			page.should have_no_content("Cebola")
			page.should have_no_content("Broculos")
		end
		And "Not see other categories displayed" do
			page.should have_no_content("Vegetais")
			page.should have_no_content("Assados")
			page.should have_no_content("Fruta")
		end
	end
	Steps "Unregistered user search by category on market page of a merchant" do
		When "I go to a merchant page" do
			page.visit "/market/Bruno"
		end
		And "I fill in search box with desired search" do
			page.fill_in "search", :with => 'Vegetais'
		end
		And "I click search" do
			page.click_link_or_button "search_button"
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
			page.should have_no_content("Assados")
			page.should have_no_content("Higiene")
			page.should have_no_content("Fruta")
		end
	end
end