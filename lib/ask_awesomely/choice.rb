module AskAwesomely
  class Choice

    attr_reader :label, :picture

    def initialize(label:, picture: nil)
      @label = label
      @picture = picture && Picture.new(picture)
      @api_client = ApiClient.new
    end

    def to_json
      json = {
        label: label
      }
      
      if picture 
        @api_client.submit_picture(picture) if picture.id.nil?
        json[:image_id] = picture.id
      end
    end
      
  end
end
