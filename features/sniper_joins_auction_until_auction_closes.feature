Feature: Sniper joins auction until auction closes

  @wip
  Scenario:
    Given the auction has started selling an item
    And I start bidding in the auction
    When the auction closes
    Then I see that I have lost the auction
