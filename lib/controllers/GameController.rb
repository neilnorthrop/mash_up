require_relative 'ApplicationController'

class GameController < ApplicationController
	def run(params)
		#BODY STUFF with params
		#return html string
		body = Haml::Engine.new(File.read('./views/board.haml')).render
		return body
	end
end