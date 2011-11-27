class Auction
  attr_reader :item_id

  def initialize(item_id)
    @item_id = item_id
  end

  def start_selling_item
    connect
    login
    on_message { |m| receive_message(m) }
  end

  def receive_message(message)
    @bidder = message.from
    message.body == 'JOIN' && @joined = true
  end

  def stop_selling_item
    message "CLOSED", @bidder
  end

  def has_received_join_request?
    @joined ||= false
  end

  private

  include Snipe::Xmpp::LogsInToAnXmppServer

  def jid
    @jid ||= Jabber::JID.new("auction-#{item_id}@localhost")
  end

  def xmpp_password
    "password"
  end
end

class Sniper
  def start_bidding_in(auction)
    connect
    login
    message "JOIN", auction_jid(auction)
    on_message { |m| receive_message(m) }
  end

  def receive_message(message)
    message.body == 'CLOSED' && @status = "Lost"
  end

  def status
    @status ||= "unknown"
  end

  private

  include Snipe::Xmpp::LogsInToAnXmppServer

  def auction_jid(auction)
    "auction-#{auction.item_id}@localhost"
  end

  def jid; "sniper@localhost"; end
  def xmpp_password; "password"; end
end

module KnowsTheDomain
  def sniper; @sniper ||= Sniper.new; end
  def auction; @auction ||= Auction.new("item-54321"); end
end

World(KnowsTheDomain)
