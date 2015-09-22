require "ask_awesomely/version"
require "ask_awesomely/configuration"
require "ask_awesomely/typeform"
require "ask_awesomely/builder"
require "ask_awesomely/field"
require "ask_awesomely/choice"
require "ask_awesomely/picture"

module AskAwesomely

  def self.included(recv)
    recv.extend(Typeform)
  end
    
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield @configuration
  end

end
