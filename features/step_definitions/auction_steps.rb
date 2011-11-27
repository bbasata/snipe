Given /^the auction has started selling an item$/ do
  auction.start_selling_item
end

When /^the auction closes$/ do
  auction.stop_selling_item
end

Then /^the auction receives a join request from me$/ do
  eventually { auction.should have_received_join_request }
end
