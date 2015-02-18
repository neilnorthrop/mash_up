require 'minitest/autorun'
require 'minitest/unit'
require './lib/board'
require './lib/computer_ai'

class TestConsoleMover < Minitest::Test
  def setup
    @board = Board.new
  end

  class StubIn
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def gets
      @input.shift
    end
  end

  def test_that_listen_gets_integers_from_input
    stubin = StubIn.new(['4.3', 'asdf', '5', "6\n", "092834\t"])
    console = ConsoleMover.new(stubin)
    assert_equal console.get_move, 4
    assert_equal console.get_move, 0
    assert_equal console.get_move, 5
    assert_equal console.get_move, 6
    assert_equal console.get_move, 92_834
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
