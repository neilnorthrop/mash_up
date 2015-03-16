require 'haml'

require_relative 'ApplicationController'

class GameController < ApplicationController
	def run(board)
		body = Haml::Engine.new(File.read('./views/board.haml')).render(Object.new, :board => board)
		return body
	end
end