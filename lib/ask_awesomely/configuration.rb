module AskAwesomely
  class Configuration

    DEFAULT_AWS_BUCKET = "typeform_io_images"
    DEFAULT_AWS_REGION = "us-east-1"

    attr_accessor :typeform_api_key,
                  :aws_access_key_id,
                  :aws_access_key_secret,
                  :aws_region,
                  :aws_bucket,
                  :logger
    
    def typeform_api_key
      unless @typeform_api_key
        raise ConfigurationError, "Typeform I/O API Key must be set before use, get one from <https://typeform.io>."
      end
      
      @typeform_api_key
    end

    def aws_region
      @aws_region || DEFAULT_AWS_REGION
    end

    def aws_bucket
      @aws_bucket || DEFAULT_AWS_BUCKET
    end

    def logger
      @logger ||= Logger.new(STDOUT).tap do |logger|
        logger.level = Logger::WARN
      end
    end

  end
end
