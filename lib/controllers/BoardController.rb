require 'haml'
require 'tempfile'
require './lib/player.rb'
require './lib/computer_ai.rb'
require './lib/board.rb'
require './lib/game.rb'

require_relative 'ApplicationController'

class BoardController < ApplicationController
	def run(params)
		body = Haml::Engine.new(File.read('./views/board.haml')).render(Object.new, :board => board.board)
		return body
	end
end