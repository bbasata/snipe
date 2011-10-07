$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'snipe'
require 'ruby-debug'

Capybara.default_driver = :selenium
Capybara.app = Snipe::Web::App
