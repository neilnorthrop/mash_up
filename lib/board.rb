#! /usr/bin/env ruby

class Board
  attr_accessor :board, :board_dimension, :winning_positions

  def initialize
    @board_dimension = 3
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winning_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  end

  def set_position(position, letter)
    (valid_position(position) && position_empty(position)) ? (@board[find_index(position)] = letter) ? true : false : false
    # if valid_position(position) && position_empty(position)
    #   @board[find_index(position)] = letter
    # else
    #   false
    # end
  end

  def valid_position(position)
    position > 0 && position <= @board.size
  end

  def find_index(position)
    position - 1
  end

  def player_moves
    moves('X')
  end

  def computer_moves
    moves('O')
  end

  def check_game
    winning_positions.each do |row|
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

  def set_at_index(index, letter)
    if board[index] =~ /X|O/
      return false
    end
    board[index] = letter
  end

  def check_position(position, _letter)
    !board.find_index(position).nil?
  end

  def move_does_not_contain(index, letter)
    board[index] != letter
  end

  def moves(letter)
    moves = []
    board.each.with_index { |v, k| moves << k + 1 if v == letter }
    moves.sort
  end

  def tally_moves_remaining
    moves_remaining = []
    @board.each do |position|
      if position != 'X' && position != 'O'
        moves_remaining << position
      end
    end
    moves_remaining
  end

  def position_empty(position)
    @board[find_index(position)] != 'X' && @board[find_index(position)] != 'O'
  end
end
