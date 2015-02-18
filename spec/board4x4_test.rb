require './lib/board4x4'
require 'minitest/autorun'
require 'minitest/unit'

class TestBoard4x4 < Minitest::Test
  def setup
    @test_game = Board4x4.new
  end

  def test_that_boardgame_constructs
    assert Board4x4.new
  end

  def test_that_boardgame_constructs_4x4_grid
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.board
  end

  def test_that_board_responds_to_calls
    assert @test_game.board
  end

  def test_that_board_will_display_to_ui
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.display_board
  end

  def test_that_board_will_respond_to_setting_position
    assert @test_game.set_position(1, 'X')
  end

  def test_that_board_responds_to_checking_for_validity_of_move
    assert @test_game.valid_position(1)
  end

  def test_that_board_checks_for_validity_of_move
    assert @test_game.valid_position(3)
    assert @test_game.valid_position(15)
  end

  def test_that_board_refutes_invalid_position
    refute @test_game.valid_position(-1)
    refute @test_game.valid_position(17)
  end

  def test_that_board_sets_X_at_position_2
    @test_game.set_position(2, 'X')
    assert_equal [1, 'X', 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.display_board
  end

  def test_that_board_responds_to_checks_position
    assert @test_game.check_position(1)
  end

  def test_that_board_checks_position
    assert @test_game.check_position(2)
  end

  def test_that_board_refutes_when_position_is_filled
    @test_game.set_position(1, 'X')
    refute @test_game.check_position(1)
  end

  def test_that_board_refuses_move_on_another_move
    @test_game.set_position(1, 'X')
    refute @test_game.set_position(1, 'X')
  end

  def test_that_position_does_not_contain_an_X_or_O
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'O')
    assert @test_game.position_empty(3)
  end

  def test_that_position_does_contain_an_X_or_O
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'O')
    refute @test_game.position_empty(1)
    refute @test_game.position_empty(2)
  end

  def test_that_board_gathers_moves_together
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'O')
    @test_game.set_position(3, 'X')
    @test_game.set_position(4, 'O')
    assert_equal [1, 3], @test_game.moves('X')
    assert_equal [2, 4], @test_game.moves('O')
  end

  def test_that_board_tallies_moves_remaining
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'X')
    @test_game.set_position(3, 'X')
    @test_game.set_position(4, 'X')
    @test_game.set_position(5, 'X')
    @test_game.set_position(6, 'X')
    assert_equal [7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.tally_moves_remaining
  end

  def test_player_moves_returns_all_moves_for_player_X
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'X')
    @test_game.set_position(3, 'X')
    @test_game.set_position(4, 'X')
    assert_equal [1, 2, 3, 4], @test_game.player_moves
  end

  def test_player_moves_returns_all_moves_for_player_O
    @test_game.set_position(1, 'O')
    @test_game.set_position(2, 'O')
    @test_game.set_position(3, 'O')
    @test_game.set_position(4, 'O')
    assert_equal [1, 2, 3, 4], @test_game.computer_moves
  end

  def test_board_responds_to_check_game
    assert_equal :nobody, @test_game.check_game
  end

  def test_that_check_game_returns_player_symbol_when_player_wins_across
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'X')
    @test_game.set_position(3, 'X')
    @test_game.set_position(4, 'X')
    assert_equal :player, @test_game.check_game
  end

  def test_that_check_game_returns_player_o_symbol_when_computer_wins
    @test_game.set_position(1, 'O')
    @test_game.set_position(2, 'O')
    @test_game.set_position(3, 'O')
    @test_game.set_position(4, 'O')
    assert_equal :computer, @test_game.check_game
  end

  def test_that_check_game_returns_draw_symbol_when_nobody_wins
    @test_game.board = %w(X O X O O X O X O X O X X O X O)
    assert_equal :draw, @test_game.check_game
  end

  def test_that_game_over_returns_false_if_no_player_wins
    refute @test_game.game_over?
  end

  def test_that_game_over_returns_true_if_a_player_O_wins_across
    @test_game.set_position(1, 'O')
    @test_game.set_position(2, 'O')
    @test_game.set_position(3, 'O')
    @test_game.set_position(4, 'O')
    assert @test_game.game_over?
  end

  def test_that_game_over_returns_true_if_a_player_X_wins_across
    @test_game.set_position(1, 'X')
    @test_game.set_position(2, 'X')
    @test_game.set_position(3, 'X')
    @test_game.set_position(4, 'X')
    assert @test_game.game_over?
  end

  def test_that_check_game_returns_player_symbol_when_player_wins_down
    @test_game.set_position(1, 'X')
    @test_game.set_position(5, 'X')
    @test_game.set_position(9, 'X')
    @test_game.set_position(13, 'X')
    assert_equal :player, @test_game.check_game
  end

  def test_that_check_game_returns_player_symbol_when_player_wins_diagonal
    @test_game.set_position(1, 'X')
    @test_game.set_position(6, 'X')
    @test_game.set_position(11, 'X')
    @test_game.set_position(16, 'X')
    assert_equal :player, @test_game.check_game
  end

  def test_that_check_game_returns_player_symbol_when_player_wins_diagonal
    @test_game.set_position(4, 'X')
    @test_game.set_position(7, 'X')
    @test_game.set_position(10, 'X')
    @test_game.set_position(13, 'X')
    assert_equal :player, @test_game.check_game
  end

  def test_that_valid_position_returns_false_when_moved_on_a_filled_position
    @test_game.set_position(1, 'X')
    assert @test_game.valid_position(1)
  end
end
