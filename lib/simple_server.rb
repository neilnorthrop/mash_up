require 'socket'
require_relative 'logging'
require_relative 'request'
require_relative 'response'
require './lib/player.rb'
require './lib/computer_ai.rb'
require './lib/board.rb'
require './lib/game.rb'
require './lib/controllers/BoardController.rb'
require './lib/controllers/GameController.rb'

class SimpleServer
  attr_reader :server, :level, :output, :host, :port, :sessions, :game

  READ_CHUNK = 1024 * 4

  LOG = Logging.setup
  LOG.debug("Logging is set up.")

  def initialize(host="localhost", port=2345)
    @host = host
    @port = port
    @server = TCPServer.new(host, port)
    LOG.debug("Server is set up.")
    @sessions = {}
    @game = setup_game
  end

  def server_info
    puts "#{'-' * 30}\nWelcome to the Simple Server.\nIt is running on http://#{host}#{(':' + port.to_s) if port}\nPlease use CONTROL-C to exit.\n#{'-' * 30}\n\n"
  end

  def run
    server_info
    begin
      loop do
        Thread.start(server.accept) do |socket|
          LOG.debug("Accepted socket: #{socket.inspect}\r\n")
          check_game_over
        begin
          data = socket.readpartial(READ_CHUNK)
        rescue EOFError
          break
        end
          logging_string(data)
          
          request = Request.parse(data)
          LOG.debug("Incoming request: #{request}\r\n")
          if request.session_id == nil
            request.session_id = SecureRandom.hex(13)
          end
          if request.resource == "/decide"
            board_controller = BoardController.new
            request.body = board_controller.run(game.board)
          elsif request.resource == '/turn'
            game_controller = GameController.new
            processing_turn(request.body)
            request.body = game_controller.run(game.board)
          end
          response = Response.build(request)
          LOG.debug("Built response: #{response}\r\n")
          logging_string(response.header)
          socket.print response.header
          socket.print response.stream
          socket.close
        end
      end
    rescue Interrupt
      puts "\nExiting...Thank you for using this super awesome server."
    end
  end

  def logging_string(string)
    string = string.split("\r\n")
    string.each do |line|
      LOG.info(line)
    end
  end

  def setup_game
    board = Board.new
    player_one = Player.new(WebMover.new, 'X')
    player_two = ComputerMover.new(board, player_one.letter)
    game = Game.new(board, player_one, player_two)
    return game
  end

  def processing_turn(turn)
    game.next_move(turn)
    game.toggle_players
    if game.current_player.class == ComputerMover
      game.next_move(turn)
      game.toggle_players
    end
  end

  def check_game_over
    if game.board.game_over?
      game = setup_game
    end
  end
end




































