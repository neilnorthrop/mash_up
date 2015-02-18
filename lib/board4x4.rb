#! /usr/bin/env ruby

class Board4x4
  attr_accessor :board, :board_dimension, :winning_positions

  def initialize
    @board_dimension = 4
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    @winning_positions = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16], [1, 6, 11, 16], [4, 7, 10, 13]]
  end

  def display_board
    board
  end

  def set_position(position, letter)
    if valid_position(position) && position_empty(position)
      @board[find_index(position)] = letter
    else
      false
    end
  end

  def valid_position(position)
    position > 0 && position <= @board.size
  end

  def check_position(position)
    @board[find_index(position)] !~ /X|O/
  end

  def find_index(position)
    position - 1
  end

  def position_empty(position)
    @board[find_index(position)] != 'X' && @board[find_index(position)] != 'O'
  end

  def moves(letter)
    moves_collected = []
    @board.each.with_index { |v, k| moves_collected << k + 1 if v == letter }
    moves_collected
  end

  def tally_moves_remaining
    moves_remaining = []
    @board.each { |position| moves_remaining << position if position !~ /X|O/ }
    moves_remaining
  end

  def player_moves
    moves('X')
  end

  def computer_moves
    moves('O')
  end

  def check_game
    @winning_positions.each do |row|
      return :player if (row - player_moves).empty?
      return :computer if (row - computer_moves).empty?
    end
    return :draw if tally_moves_remaining.empty?
    :nobody
  end

  def game_over?
    check_game != :nobody
  end

  def game_over_message
    case check_game
    when :player
      'PLAYER WON!'
    when :computer
      'COMPUTER WON!'
    when :draw
      "IT'S A DRAW!"
    when :nobody
      "GAME ISN'T OVER DUDE!"
    end
  end
end
