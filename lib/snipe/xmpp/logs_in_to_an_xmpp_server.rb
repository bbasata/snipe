module Snipe
  module Xmpp
    module LogsInToAnXmppServer
      def client
        @client ||= Jabber::Client.new jid
      end

      def connect
        begin
          client.connect
        rescue => e
          raise "Auction failed to connect to XMPP server.\nSuggestion: is an XMPP server like openfire installed and running on host '#{jid.domain}'?" + e.to_s
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
  end
end
