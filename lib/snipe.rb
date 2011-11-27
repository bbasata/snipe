require 'snipe/web'
require 'snipe/xmpp'

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
