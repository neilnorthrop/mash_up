#! /usr/bin/env ruby

class ComputerAI
  def self.get_move(board, me, opponent)
    board = board
    my_moves = board.moves(me)
    opponent_moves = board.moves(opponent)

    if opponent_moves.count == 1
      opening_move(opponent_moves)
    else
      move = next_win_or_block(board, my_moves)
      move = next_win_or_block(board, opponent_moves) if move == :none
      move = blocking_fork(board, opponent_moves) if move == :none
      move = board.tally_moves_remaining.sample if move == :none
      return move
    end
  end

  def self.opening_move(opponent_moves)
    !opponent_moves.include?(5) ? 5 : 1
  end

  def self.next_win_or_block(board, moves)
    results = board.winning_positions.select { |row| (row - moves).count == 1 }
    matches = results.flatten.select { |position| board.position_empty(position) }
    matches.shift || :none
  end

  def self.blocking_fork(board, opponent_moves)
    blockings = {
      [[1, 3, 6, 8]] => board.tally_moves_remaining.sample,
      [[1, 6, 7]] => 4,
      [[2, 4]] => 1,
      [[6, 8], [2, 6], [5, 9], [1, 6]] => 3,
      [[4, 8]] => 7,
      [[1, 9], [3, 7]] => 2,
      [[1, 8]] => 4
    }
    blockings.select do |moves, _block|
      moves.include?(opponent_moves)
    end.values.first || :none
  end
end
