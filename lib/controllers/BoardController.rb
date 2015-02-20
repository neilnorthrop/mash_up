require_relative 'ApplicationController'

class BoardController < ApplicationController
	def run
		#BODY STUFF with params

		Haml::Engine.new("%p= foo").render(Object.new, { :id =>  })
		#return html string
	end
end