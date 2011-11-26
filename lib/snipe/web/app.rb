require 'sinatra/base'

module Snipe
  module Web
    class App < Sinatra::Base
      helpers do
        def auction_result
          @auction_result ||= ''
        end
      end

      get '/' do
        erb :index
      end
      post '/' do
        @auction_result = 'Lost'
        erb :index
      end
    end
  end
end
