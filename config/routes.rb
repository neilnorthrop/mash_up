# require '../lib/Router.rb'
require File.expand_path '../../lib/Router.rb', __FILE__

Router.draw do
	# get 	'/' 			=> 'game#run'
	# post  'decide' 	=> 'board#run'
	# get 	'board' 	=> 'board#run'
	# post  'turn' 		=> 'board#run'
	"get '/' => 'game#run'\n" +
	"post 'decide' => 'board#run'\n" +
	"get 'board' => 'board#run'\n" + 
	"post 'turn' => 'board#run'\n"
end