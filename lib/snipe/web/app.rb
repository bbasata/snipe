require 'sinatra/base'
require 'drb'

module Snipe
  module Web
    class App < Sinatra::Base
      helpers do
        def sniper
          @sniper ||= DRbObject.new_with_uri("druby://localhost:23232")
        end
        def auction_result
          @auction_result ||= sniper.status
        end
      end

      get '/' do
        erb :index
      end
      post '/' do
        sniper.start_bidding_in("item-54321")
        erb :index
      end
    end
  end
end
