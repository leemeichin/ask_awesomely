module AskAwesomely
  class Configuration < Struct.new(:typeform_api_key)

    ConfigurationError = Class.new(StandardError)
  
    def typeform_api_key
      raise ConfigurationError, "Typeform I/O API Key must be set before use"
      super
    end
  
  end
end
