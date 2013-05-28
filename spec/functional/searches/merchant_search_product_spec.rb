require 'spec_helper'

feature "Merchant search" do
	Steps "Merchant searches a product on his inventory" do
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
			page.visit "/products"
		end
		And "I fill in search box with 'Cenoura'" do
			page.fill_in "search", :with => "Cenoura"
		end
		And "I click on serch button" do
			page.click_button "search_button"
		end
		Then "I should see 'cenoura' item" do
			page.should have_content("Cenoura")
			page.should have_content("Vegetais")
			page.should have_content("1.33")
		end
		And "Not see other category items" do
			page.should have_no_content("Fruta")
			page.should have_no_content("Assados")
			page.should have_no_content("Higiene")
		end
		Then "I should reset search" do
			page.fill_in "search", :with => ""
			page.click_button "search_button"
		end
		And "I should see all products displayed" do
			page.should have_content("Cenoura")
			page.should have_content("Papel higienico")
			page.should have_content("Tomate")
			page.should have_content("Pimento")
			page.should have_content("Alface")
			page.should have_content("Frango Assado")
		end
		And "I fill in search box with 'Vegetais'" do
			page.fill_in "search", :with => "Vegetais"
		end
		And "I click on serch button" do
			page.click_button "search_button"
		end
		Then "I should see some items of category 'Vegetais'" do
			page.should have_content("Cenoura")
			page.should have_content("Tomate")
			page.should have_content("Pimento")
			page.should have_content("Broculos")
			page.should have_content("Cebola")
		end
		And "Not see other categories displayed" do
			page.should have_no_content("Fruta")
			page.should have_no_content("Assados")
			page.should have_no_content("Higiene")
		end 
		And "Not see items from other categories" do
			page.should have_no_content("Frango Assado")
			page.should have_no_content("Papel higienico")
			page.should have_no_content("Cotonetes")
		end
	end
end