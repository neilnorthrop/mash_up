require 'minitest/autorun'
require 'minitest/unit'
require './lib/board.rb'
require './lib/player.rb'

class TestGame < Minitest::Test
  def setup
    @board = Board.new
    @player_one = Player.new(ConsoleMover.new($stdin), 'X')
    @game = Game.new(@board, @player_one, Player.new(ComputerMover.new(@board, @player_one), 'O'), ConsoleOutput.new)
  end

  # def test_that_say_passed_a_message_to_puts
  #   stubout = StubOut.new
  #   console = ConsoleMover.new(nil, stubout)
  #   console.say("Hello")
  #   assert_equal stubout.output, "Hello"
  # end
  #
  # def test_that_get_move_keeps_asking_for_a_valid_move
  #   stubin = StubIn.new(["asdf", " ", "-1", "3"])
  #   stubout = StubOut.new
  #   console = ConsoleMover.new(stubin, stubout)
  #   assert_equal console.get_move(@board, "X", "O"), 3
  # end
  #
  # def test_that_get_move_keeps_asking_until_an_empty_position_is_given
  #   @board.set_position 1, "X"
  #   stubin = StubIn.new(["1", "2"])
  #   stubout = StubOut.new
  #   console = ConsoleMover.new(stubin, stubout)
  #   assert_equal console.get_move(@board, "X", "O"), 2
  # end
end
