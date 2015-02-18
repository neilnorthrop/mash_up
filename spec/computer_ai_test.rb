require './lib/computer_ai'
require 'minitest/autorun'
require 'minitest/unit'
require './lib/board.rb'

class TestComputerAI < Minitest::Test
  def setup
    @board = Board.new
    @me = 'O'
    @opponent = 'X'
  end

  def test_computer_turn_takes_the_win_down
    @board.set_position(1, 'O')
    @board.set_position(4, 'O')
    @board.set_position(2, 'X')
    @board.set_position(3, 'X')
    @board.set_position(6, 'X')
    assert_equal 7, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_takes_the_win_across
    @board.set_position(1, 'O')
    @board.set_position(2, 'O')
    @board.set_position(4, 'X')
    @board.set_position(7, 'X')
    @board.set_position(6, 'X')
    assert_equal 3, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_takes_the_win_diagonal
    @board.set_position(1, 'X')
    @board.set_position(2, 'X')
    @board.set_position(3, 'O')
    @board.set_position(5, 'O')
    @board.set_position(6, 'X')
    assert_equal 7, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_players_fork
    @board.set_position(1, 'X')
    @board.set_position(2, 'X')
    @board.set_position(4, 'X')
    @board.set_position(5, 'O')
    @board.set_position(6, 'O')
    assert_equal 3, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_players_positioning_for_a_top_left_fork
    @board.set_position(2, 'X')
    @board.set_position(4, 'X')
    @board.set_position(5, 'O')
    assert_equal 1, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_players_positioning_for_a_top_right_fork
    @board.set_position(2, 'X')
    @board.set_position(6, 'X')
    @board.set_position(5, 'O')
    assert_equal 3, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_players_positioning_for_a_bottom_left_fork
    @board.set_position(4, 'X')
    @board.set_position(8, 'X')
    @board.set_position(5, 'O')
    assert_equal 7, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_players_positioning_for_a_bottom_right_fork
    @board.set_position(6, 'X')
    @board.set_position(8, 'X')
    @board.set_position(5, 'O')
    assert_equal 3, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_edge_case_for_computer_block
    @board.set_position(1, 'X')
    @board.set_position(6, 'X')
    @board.set_position(7, 'X')
    @board.set_position(3, 'O')
    @board.set_position(5, 'O')
    assert_equal 4, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_player_across
    @board.set_position(1, 'X')
    @board.set_position(2, 'X')
    assert_equal 3, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_player_down
    @board.set_position(1, 'X')
    @board.set_position(4, 'X')
    assert_equal 7, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_player_down_the_middle
    @board.set_position(1, 'O')
    @board.set_position(2, 'X')
    @board.set_position(3, 'O')
    @board.set_position(5, 'X')
    @board.set_position(7, 'X')
    assert_equal 8, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_computer_turn_blocks_player_diagonal
    @board.set_position(5, 'X')
    @board.set_position(1, 'X')
    assert_equal 9, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_on_opening_computer_turn_takes_middle_if_open
    @board.set_position(1, 'X')
    assert_equal 5, ComputerAI.get_move(@board, @me, @opponent)
  end

  def test_on_opening_computer_turn_takes_middle_outter_if_open
    @board.set_position(5, 'X')
    assert_equal 1, ComputerAI.get_move(@board, @me, @opponent)
  end
end
