require 'spec_helper'

feature "Merchant register" do
  Steps "Register a merchant" do
    When "I go to client merchant page" do
      page.visit "/register/merchant"
    end
    And "I fill in name" do
      page.fill_in "merchant[name]", :with => 'Test'
    end
	And "I fill in desired email" do
      page.fill_in "user_email", :with => 'testemail@test.com'
    end
    And "I fill in desired password" do
      page.fill_in "user_password", :with => 'testtest'
    end
	And "I fill in password confirmation" do
      page.fill_in "user_password_confirmation", :with => 'testtest'
    end
	And "I click register" do
      page.click_button "Register"
    end
    Then "I should see greeting" do
      page.should have_content("Hello")
    end
  end
end