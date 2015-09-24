module AskAwesomely
  class Picture

    attr_reader :file_or_url

    def initialize(file_or_url)
      @file_or_url = file_or_url
    end

    def public_url
      return file_or_url if url?

      uploaded_file = upload_file!
      uploaded_file.public_url
    end

    private

    def url?
      file_or_url.to_s =~ %r(https?://)
    end

    def file?
      Pathname.new(file_or_url.to_s).file?
    end

    def file
      @file ||= Pathname.new(file_or_url)
    end

    def name
      file.basename
    end
    
    def upload_file!
      AskAwesomely.configuration.tap do |config|
        config.configure_aws!
        uploaded_file = config.s3_bucket.obj(name).upload_file(file.to_s)
      end

      uploaded_file
    end

  end
end
