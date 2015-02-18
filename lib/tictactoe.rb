require './lib/simple_server.rb'
require './lib/game.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/board4x4.rb'
require './lib/computer_ai.rb'

# set :root, File.dirname('../')
# enable :sessions
# set :session_secret, 'So0perSeKr3t!'

get '/' do
  haml :game
end

post '/decide' do
  player_one = Player.new(WebMover.new, 'X')
  which_board(params[:board])
  player_two = which_opponent(params[:opponent], player_one)
  build_game(player_one, player_two)
  redirect '/board'
end

get '/board' do
  haml :board
end

post '/turn' do
  next_move_and_toggle(params)
  redirect '/board' if session['board'].game_over?
  redirect '/board' if session['game'].current_player.mover.requires_interaction?
  next_move_and_toggle(params)
  redirect '/board'
end

not_found do
  halt 404, 'page not found!'
end

def player_one
  session['player_one']
end

def player_two
  session['player_two']
end

def next_move_and_toggle(params)
  session['game'].next_move(params)
  session['game'].toggle_players
end

def which_board(size)
  size == '4x4' ? (session['board'] = Board4x4.new) : (session['board'] = Board.new)
end

def which_opponent(player, player_one)
  player == 'Computer' ? Player.new(ComputerMover.new(session['board'], player_one.letter), 'O') : Player.new(WebMover.new, 'O')
end

def build_game(player_one, player_two)
  session['game'] = Game.new(session['board'], player_one, player_two)
end
