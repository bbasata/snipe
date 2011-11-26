class FakeAuctionServer
  def initialize(item_id)
  end

  def start_selling_item
    @selling = true
  end

  def stop_selling_item
    @selling = false
  end

  def selling?
    @selling
  end
end

Given /^the auction has started selling an item$/ do
  @auction_server = FakeAuctionServer.new("item-54321")
  @auction_server.start_selling_item
  @auction_server.should be_selling
end

Given /^I start bidding in the auction$/ do
  visit '/'
  click_button 'Start Bidding'
end

When /^the auction closes$/ do
  @auction_server.stop_selling_item
  @auction_server.should_not be_selling
end

Then /^I see that I have lost the auction$/ do
  page.should have_content('Lost')
end

After do |scenario|
  save_and_open_page if scenario.failed?
end
