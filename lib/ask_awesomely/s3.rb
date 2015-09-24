module AskAwesomely
  class S3

    extend Forwardable
    
    delegate %i(
      aws_access_key_id
      aws_access_key_secret
      aws_region
      aws_bucket
      has_aws_credentials?
    ) => "AskAwesomely.configuration"

    delegate :public_url => :s3_object

    attr_reader :file, :s3_object

    def initialize(file)
      @file = file
    end

    def self.upload(file)
      new(file).tap(&:upload_file)
    end

    def upload_file
      ensure_credentials_set!
      @s3_object = bucket.object(file.basename.to_s).tap do |obj|
        obj.upload_file(file.to_s)
      end
    end

    private

    def ensure_credentials_set!
      unless aws_access_key_id && aws_access_key_secret
        raise ConfigurationError, "AWS Access Key ID and AWS Access Key Secret must be set before use"
      end
    end

    def credentials
      Aws::Credentials.new(aws_access_key_id, aws_access_key_secret)
    end

    def bucket
      Aws::S3::Resource.new(region: aws_region, credentials: credentials)
        .bucket(aws_bucket)
    end
    
  end
end
