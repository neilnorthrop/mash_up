require 'haml'
require 'tempfile'
require './lib/player.rb'
require './lib/computer_ai.rb'
require './lib/board.rb'
require './lib/game.rb'

require_relative 'ApplicationController'

class BoardController < ApplicationController
	def run(params)
		board = Board.new
		player_one = Player.new(WebMover.new, 'X')
		player_two = which_opponent(params[:opponent], player_one)
		game = Game.new(Board.new, player_one, player_two)
		body = Haml::Engine.new(File.read('./views/board.haml')).render(Object.new, :board => board.board)
		return body
	end

	def which_opponent(player, player_one)
	  player == 'Computer' ? Player.new(ComputerMover.new(board, player_one.letter), 'O') : Player.new(WebMover.new, 'O')
	end
end