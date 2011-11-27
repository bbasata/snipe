Given /^I start bidding in the auction$/ do
  sniper.start_bidding_in(auction.item_id)
end

Then /^I have lost the auction$/ do
  eventually { sniper.status.should == 'Lost' }
end
