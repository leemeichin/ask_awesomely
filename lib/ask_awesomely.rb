require "ask_awesomely/version"
require "ask_awesomely/configuration"
require "ask_awesomely/dsl"
require "ask_awesomely/field"
require "ask_awesomely/choice"
require "ask_awesomely/picture"

require "aws-sdk"

module AskAwesomely

  ConfigurationError = Class.new(ArgumentError)
  FieldTypeError = Class.new(TypeError)

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield @configuration
  end

end
