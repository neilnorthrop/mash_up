#! /usr/bin/env ruby

class Game
  attr_reader :board, :current_player

  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
    @player_collection = [@player_one, @player_two]
  end

  def next_move(args)
    @board.set_position(@current_player.get_move(args), @current_player.letter)
  end

  def toggle_players
    @current_player = (@player_collection - [@current_player]).shift
  end
end

class WebOutput
  def display(board)
    board.display_board
  end
end
