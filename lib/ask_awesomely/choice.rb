module AskAwesomely
  class Choice

    include JsonBuilder

    attr_reader :state

    def initialize(label:, picture: nil)
      @state = OpenStruct.new(
        label: label.to_s,
      )

      if picture 
        @state[:image_id] = proc { Picture.new(picture).typeform_id }
      end
    end

  end
end
