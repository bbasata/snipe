$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'service_manager'
require 'snipe'
require 'xmpp4r'

Capybara.app = Snipe::Web::App
