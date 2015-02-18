require 'rspec'
require 'capybara'
require 'capybara/rspec'
# require File.expand_path '../../tictactoe.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  include Capybara::DSL
end

RSpec.configure { |c| c.include RSpecMixin; }
