class Auction
  def initialize(item_id)
  end

  def start_selling_item
    @selling = true
  end

  def stop_selling_item
    @selling = false
    @announcer.call
  end

  def selling?
    @selling
  end

  def join(&announcer)
    @joined = true
    @announcer = announcer
  end

  def has_received_join_request?
    @joined ||= false
  end
end

class Sniper
  def start_bidding_in(auction)
    auction.join do
      receive_message
    end
  end

  def receive_message
    @status ||= "Lost"
  end

  def status
    "Won"
  end
end

module KnowsTheDomain
  def sniper; @sniper ||= Sniper.new; end
  def auction; @auction ||= Auction.new("item-54321"); end
end

World(KnowsTheDomain)

Given /^the auction has started selling an item$/ do
  auction.start_selling_item
  auction.should be_selling
end

Given /^I start bidding in the auction$/ do
  sniper.start_bidding_in(auction)
end

When /^the auction closes$/ do
  auction.stop_selling_item
  auction.should_not be_selling
end

Then /^the auction receives a join request from me$/ do
  auction.should have_received_join_request
end

Then /^I see that I have lost the auction$/ do
  sniper.status.should == 'Lost'
end
