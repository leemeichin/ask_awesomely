module AskAwesomely
  class Choice

    attr_reader :state, :picture

    def initialize(label:, picture: nil)
      @state = OpenStruct.new(label: label.to_s)
      @picture = picture && Picture.new(picture)
    end

    def build_json(context = nil)
      @state.image_id = picture && picture.typeform_id

      state.to_h.reduce({}) do |json, (k, v)|
        json[k] = v.respond_to?(:call) ? v.call(context) : v
        json
      end
    end
      
  end
end
