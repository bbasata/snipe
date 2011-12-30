require 'drb'
require 'snipe'

DRb.start_service 'druby://127.0.0.1:23232', Sniper.new
DRb.thread.join
