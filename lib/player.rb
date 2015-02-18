#! /usr/bin/env ruby
require_relative 'computer_ai'

class Player
  attr_accessor :mover, :letter

  def initialize(mover, letter)
    @mover = mover
    @letter = letter
  end

  def get_move(args = {})
    @mover.get_move(args)
  end
end

class Mover
  def get_move(_args)
    fail 'MAKE A METHOD!'
  end

  def requires_interaction?
    true
  end
end

class ConsoleMover < Mover
  def initialize(input)
    @input = input
  end

  def get_move(_args = {})
    @input.gets.chomp.to_i
  end
end

class ComputerMover < Mover
  def initialize(board, opponent)
    @board = board
    @opponent = opponent
  end

  def get_move(_args = {})
    ComputerAI.get_move(@board, 'O', @opponent)
  end

  def requires_interaction?
    false
  end
end

class WebMover < Mover
  def get_move(args = {})
    args[:player_move].to_i
  end
end
