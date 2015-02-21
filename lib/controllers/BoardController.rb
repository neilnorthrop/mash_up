require 'haml'
require 'tempfile'

require_relative 'ApplicationController'

class BoardController < ApplicationController
	def run(params)
		# return "#{params['opponent']}"
		# Haml::Engine.new("%p= foo").render(Object.new, { :id =>  })
		body = Haml::Engine.new(File.read('./views/board.haml')).render
		return body
	end
end