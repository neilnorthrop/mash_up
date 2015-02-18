ENV['RACK_ENV'] = 'test'

require './lib/board.rb'
require 'minitest/autorun'
require 'minitest/unit'

class TestBoard < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_building_board_class
    assert @board
  end

  def test_game_class_responds_to_board
    assert @board.board
  end

  def test_game_includes_default_size_board
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], @board.board
  end

  def test_game_is_a_draw
    @board.set_position(1, 'X')
    @board.set_position(3, 'X')
    @board.set_position(4, 'X')
    @board.set_position(8, 'X')
    @board.set_position(9, 'X')
    @board.set_position(2, 'O')
    @board.set_position(5, 'O')
    @board.set_position(6, 'O')
    @board.set_position(7, 'O')
    assert_equal :draw, @board.check_game
  end

  def test_player_wins_with_full_game_board
    @board.set_position(1, 'X')
    @board.set_position(6, 'O')
    @board.set_position(7, 'X')
    @board.set_position(8, 'X')
    @board.set_position(9, 'X')
    @board.set_position(2, 'O')
    @board.set_position(3, 'O')
    @board.set_position(4, 'X')
    @board.set_position(5, 'O')
    assert_equal :player, @board.check_game
  end

  def test_computer_wins_with_full_game_board
    @board.set_position(1, 'X')
    @board.set_position(2, 'X')
    @board.set_position(5, 'X')
    @board.set_position(7, 'X')
    @board.set_position(3, 'O')
    @board.set_position(4, 'O')
    @board.set_position(6, 'O')
    @board.set_position(8, 'O')
    @board.set_position(9, 'O')
    assert_equal :computer, @board.check_game
  end

  def test_building_default_board_size
    assert_kind_of Array, @board.board
  end

  def test_setting_an_X_position_on_the_board
    @board.set_position(1, 'X')
    assert_includes @board.board, 'X'
  end

  def test_setting_an_O_position_on_the_board
    @board.set_position(1, 'O')
    assert_includes @board.board, 'O'
  end

  def test_setting_another_position_on_the_board
    @board.set_position(2, 'X')
    @board.set_position(4, 'X')
    assert_equal [1, 'X', 3, 'X', 5, 6, 7, 8, 9], @board.board
  end

  def test_setting_a_position_ontop_of_another_position
    @board.set_position(2, 'X')
    assert_equal false, @board.set_position(2, 'X')
  end

  def test_that_board_responds_to_display
    assert_respond_to @board, :display, "#{@board} does not respond to display"
  end

  def test_that_board_checks_for_player_position_at_1
    @board.set_position(1, 'X')
    assert_equal false, @board.check_position(1, 'X')
  end

  def test_that_board_checks_for_player_position_at_2
    @board.set_position(1, 'X')
    assert_equal true, @board.check_position(2, 'X')
  end

  def test_setting_an_X_index_position
    @board.set_at_index(1, 'X')
    assert_equal [1, 'X', 3, 4, 5, 6, 7, 8, 9], @board.board
  end

  def test_setting_X_index_position_on_top_of_another_X
    @board.set_at_index(1, 'X')
    assert_equal false, @board.set_at_index(1, 'X')
  end

  def test_that_position_does_not_contain_an_X
    @board.set_position(1, 'X')
    assert_equal true, @board.move_does_not_contain(9, 'X')
  end

  def test_that_position_does_contain_an_X
    @board.set_position(1, 'X')
    assert_equal false, @board.move_does_not_contain(0, 'X')
  end

  def test_that_game_over_message_returns_default_message
    assert "GAME ISN'T OVER DUDE!", @board.game_over_message
  end

  def test_player_wins_three_in_a_row_across
    @board.set_position(1, 'X')
    @board.set_position(2, 'X')
    @board.set_position(3, 'X')
    assert_equal :player, @board.check_game
  end

  def test_player_wins_three_in_a_row_down
    @board.set_position(1, 'X')
    @board.set_position(4, 'X')
    @board.set_position(7, 'X')
    assert_equal :player, @board.check_game
  end

  def test_player_wins_three_in_a_row_diagonal
    @board.set_position(1, 'X')
    @board.set_position(5, 'X')
    @board.set_position(9, 'X')
    assert_equal :player, @board.check_game
  end

  def test_computer_wins_three_in_a_row_across
    @board.set_position(1, 'O')
    @board.set_position(2, 'O')
    @board.set_position(3, 'O')
    assert_equal :computer, @board.check_game
  end

  def test_computer_wins_three_in_a_row_down
    @board.set_position(1, 'O')
    @board.set_position(4, 'O')
    @board.set_position(7, 'O')
    assert_equal :computer, @board.check_game
  end

  def test_computer_wins_three_in_a_row_diagonal
    @board.set_position(1, 'O')
    @board.set_position(5, 'O')
    @board.set_position(9, 'O')
    assert_equal :computer, @board.check_game
  end
end
