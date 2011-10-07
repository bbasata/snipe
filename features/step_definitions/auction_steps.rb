class FakeAuctionServer
  def initialize(item_id)
  end

  def start_selling_item
  end

  def stop_selling_item
  end
end

Given /^the auction has started selling an item$/ do
  @auction_server = FakeAuctionServer.new("item-54321")
  @auction_server.start_selling_item
end

Given /^I start bidding in the auction$/ do
  visit '/'
  click_button 'Start Bidding'
end

When /^the auction closes$/ do
  @auction_server.stop_selling_item
end

Then /^I see that I have lost the auction$/ do
  page.should have_content('Lost')
end
