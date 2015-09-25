require "ask_awesomely/version"
require "ask_awesomely/configuration"
require "ask_awesomely/dsl"
require "ask_awesomely/field"
require "ask_awesomely/choice"
require "ask_awesomely/picture"
require "ask_awesomely/s3"

require "json"
require "aws-sdk"

module AskAwesomely

  ConfigurationError = Class.new(ArgumentError)
  FieldTypeError = Class.new(TypeError)

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    block.call(self.configuration)
  end

end
