Feature: Sniper joins auction until auction closes

  Scenario:
    Given the auction has started selling an item
    And I start bidding in the auction
    Then the auction receives a join request from me
    When the auction closes
    Then I have lost the auction
