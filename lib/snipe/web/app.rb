require 'sinatra/base'

module Snipe
  module Web
    class App < Sinatra::Base
      # start the server if ruby file executed directly
      run! if app_file == $0
    end
  end
end
