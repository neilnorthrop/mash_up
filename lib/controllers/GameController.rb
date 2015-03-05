require_relative 'ApplicationController'

class GameController < ApplicationController
	def run(params)
		board = Board.new
		#BODY STUFF with params
		#return html string
		body = Haml::Engine.new(File.read('./views/board.haml')).render(Object.new, :board => board.board)
		return body
	end
end