module AskAwesomely
  class Configuration

    DEFAULT_BUCKET = "typeform_io_images"
    DEFAULT_REGION = "us-east-1"

    attr_accessor :typeform_api_key,
                  :aws_access_key_id,
                  :aws_access_key_secret,
                  :aws_region,
                  :aws_bucket
    
    def typeform_api_key
      unless @typeform_api_key
        raise ConfigurationError, "Typeform I/O API Key must be set before use, get one from <https://typeform.io>."
      end
      
      super
    end

    def aws_region
      super || DEFAULT_REGION
    end

    def aws_bucket
      super || DEFAULT_BUCKET
    end

    def has_aws_credentials?
      aws_access_key_id && aws_access_key_secret
    end

    def configure_aws!
      unless has_aws_credentials?
        raise ConfigurationError, "AWS Access Key ID & AWS Access Key Secret must be set before use"
      end
      
      Aws.config.update({
        region: aws_region,
        credentials: aws_credentials
      })
    end

    def s3_bucket
      Aws::S3::Resource.new.bucket(aws_bucket)
    end
    
    private
    
    def aws_credentials
      Aws::Credentials.new(aws_access_key_id, aws_access_key_secret)
    end

  end
end
