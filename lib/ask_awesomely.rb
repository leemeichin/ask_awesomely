require "ask_awesomely/version"
require "ask_awesomely/configuration"
require "ask_awesomely/dsl"
require "ask_awesomely/field"
require "ask_awesomely/choice"
require "ask_awesomely/picture"
require "ask_awesomely/s3"
require "ask_awesomely/api_client"
require "ask_awesomely/typeform"
require "ask_awesomely/embeddable"

require "json"
require "uri"
require "erubis"
require "aws-sdk"
require "typhoeus"

module AskAwesomely

  ConfigurationError = Class.new(ArgumentError)
  FieldTypeError = Class.new(ArgumentError)
  EmbedTypeError = Class.new(ArgumentError)
  InvalidUrlError = Class.new(TypeError)

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    block.call(self.configuration)
  end

end
