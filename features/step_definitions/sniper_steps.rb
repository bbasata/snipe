Given /^I start bidding in the auction$/ do
  sniper.start_bidding_in(auction)
end

Then /^I see that I have lost the auction$/ do
  sniper.status.should == 'Lost'
end
