$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'snipe'

Capybara.app = Snipe::Web::App
