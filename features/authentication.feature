Feature: Authentication

  Scenario: user logs in
    Given a user with email "m@m.m" and password "bbbbbbbb"
    When I sign in manually as "m@m.m" with password "bbbbbbbb"
    Then I should be able to logout

  Scenario: user logs out
    Given I am an authenticated user
    When I press Logout
    Then I should be on the getting started page

  Scenario: new merchant registration
    When I go to the new merchant registration page
    And I fill in the following:
      | user_email                 |   merchant@test.com       |
      | user_password              |     bbbbbbbb          |
      | user_password_confirmation |     bbbbbbbb          |
    And I press "Continue"
    Then I should be on the merchant getting started page

  Scenario: new client registration
    When I go to the new client registration page
    And I fill in the following:
      | user_email                 |   client@test.com     |
      | user_password              |     bbbbbbbb          |
      | user_password_confirmation |     bbbbbbbb          |
    And I press "Continue"
    Then I should be on the client getting started page
