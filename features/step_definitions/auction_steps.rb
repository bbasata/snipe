Given /^the auction has started selling an item$/ do
  auction.start_selling_item
  auction.should be_selling
end

When /^the auction closes$/ do
  auction.stop_selling_item
  auction.should_not be_selling
end

Then /^the auction receives a join request from me$/ do
  auction.should have_received_join_request
end
