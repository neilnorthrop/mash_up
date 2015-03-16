require 'securerandom'

class Request
	attr_reader :method, :resource, :version
  attr_accessor :session_id, :body

	def initialize(method, resource, version, body=nil, session=nil)
		@method = method
		@resource = resource
		@version = version
		@body = body
    @session_id = session
	end

	def self.parse(string)
    session = get_session(string)
    body = get_body(string)
    pattern = /\A(?<method>\w+)\s+(?<resource>\S+)\s+(?<version>\S+)/
    match = pattern.match(string)
    Request.new(match["method"], match["resource"], match["version"], body, session)
  end

  def self.get_body(string)
  	if string.split("\r\n\r\n")[1]
  		body = string.split("\r\n\r\n")[1]
      params = {}
      array_of_body = (body).split("&")
      array_of_body.each do |word|
        key, value = word.split("=")
        params[key] = value
      end
      return params
  	else
  		return ""
  	end
  end

  def self.get_session(string)
    pattern = /Cookie\S\s(?<cookie>.+)/
    match = pattern.match(string)
    return match["cookie"] if match
  end
end