require 'socket'

class Response
  attr_reader :header, :body

  def initialize(header, body)
    @header = header
    @body = body
    puts body.object_id
  end

	RESPONSE_CODE = {
		'200' => 'OK',
		'404' => 'Not Found'
	}

  CONTENT_TYPE_MAPPING = {
    'html' => 'text/html',
    'txt'  => 'text/plain',
    'png'  => 'image/png',
    'jpg'  => 'image/jpg',
    'haml' => 'text/html'
  }

  DEFAULT_CONTENT_TYPE = 'application/octet-stream'

  NOT_FOUND = './public/404.html'
  WEB_ROOT = './views'

	def self.build(request)
    case 
    when request.method == "GET"
      get(request)
    when request.method == "POST"
      post(request)
    end
	end

  def self.get(request)
    path = clean_path(request.resource)
    path = File.join(path, 'index.html') if File.directory?(path)
    if File.exist?(path) && !File.directory?(path)
      body, body_size = build_body(path)
      header = build_header(RESPONSE_CODE.rassoc('OK').join("/"),
                           content_type(path),
                           body_size)
      Response.new(header, body)
    else
      body, body_size = build_body(NOT_FOUND)
      header = build_header(RESPONSE_CODE.rassoc('Not Found').join("/"),
                           content_type(path),
                           body_size)
      puts body.object_id
      Response.new(header, body)
    end
  end

  def self.post(request)
    params = {}
    array_of_body = (request.body).split("&")
    array_of_body.each do |word|
      key, value = word.split("=")
      params[key] = value
    end
    # if request.resource? == 'decide'
    #   body = BoardController.new.run(params)
    # elsif request.resource? == 'turn'
    #   body = GameController.new.run(params)
    # end
    header = "HTTP/1.1 #{RESPONSE_CODE.rassoc('OK').join("/")}\r\n" + 
             "Content-Type: text/plain\r\n\r\n"
    Response.new(header, body)
  end
  
  def self.clean_path(path)
    clean = []

    parts = path.split("/")
    parts.each do |part|
      next if part.empty? || part == '.'
      part == '..' ? clean.pop : clean << part
    end 
    File.join(WEB_ROOT, *clean)
  end

  def self.content_type(path)
    ext = File.extname(path).split('.').last
    CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
  end

  def self.build_header(code, type, size)
    "HTTP/1.1 #{code}\r\n" + 
		"Content-Type: #{type}\r\n" +
		"Content-Length: #{size}\r\n" +
		"Connection: close\r\n\r\n"
  end

  def self.build_body(path)
    File.open(path, "rb") do |file|
      return file, file.size
    end
  end

  def stream
    if self.body.is_a?(File)
      File.read(self.body)
    else
      return self.body
    end
  end
end