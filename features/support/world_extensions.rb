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
    @status ||= "unknown"
  end
end

module KnowsTheDomain
  def sniper; @sniper ||= Sniper.new; end
  def auction; @auction ||= Auction.new("item-54321"); end
end

World(KnowsTheDomain)


