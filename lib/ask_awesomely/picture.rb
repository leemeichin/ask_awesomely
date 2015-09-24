module AskAwesomely
  class Picture

    attr_reader :file_or_url, :public_url, :type, :typeform_id

    DEFAULT_TYPE = :choice
    
    PICTURE_TYPES = [
      :choice
    ]

    def initialize(file_or_url, type: DEFAULT_TYPE)
      @file_or_url = file_or_url
      @type = type
    end

    def public_url
      @public_url ||= if url?
        file_or_url
      else
        file = upload_to_s3
        file.public_url
      end
    end

    private

    def url?
      file_or_url.to_s =~ %r(https?://)
    end

    def file?
      Pathname.new(file_or_url.to_s).file?
    end

    def upload_to_s3
      S3.upload(Pathname.new(file_or_url))
    end

  end
end
