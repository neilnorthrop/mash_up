require 'socket'
require_relative 'logging'
require_relative 'request'
require_relative 'response'

class SimpleServer
  attr_reader :server, :level, :output, :host, :port, :sessions

  READ_CHUNK = 1024 * 4

  LOG = Logging.setup
  LOG.debug("Logging is set up.")

  def initialize(host="localhost", port=2345)
    @host = host
    @port = port
    @server = TCPServer.new(host, port)
    LOG.debug("Server is set up.")
    @sessions = {}
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
end