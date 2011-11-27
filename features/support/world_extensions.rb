module LogsInToAnXmppServer
  def client
    @client ||= Jabber::Client.new jid
  end

  def connect
   begin
     client.connect
    rescue
      raise "Auction failed to connect to XMPP server.\nSuggestion: is an XMPP server like openfire installed and running on host '#{jid.domain}'?"
    end
  end

  def login
    begin
      client.auth xmpp_password
      client.send(Jabber::Presence.new)
    rescue => e
      raise "Auction failed to authenticate to XMPP server.\nSuggestion: does user '#{jid}' with password '#{xmpp_password}' exist?\n" + e.to_s
    end
  end

  def message(body, destination)
    client.send Jabber::Message.new(destination, body)
  end

  def on_message(&block)
    client.add_message_callback(&block)
  end
end

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

  include LogsInToAnXmppServer

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

  include LogsInToAnXmppServer

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
