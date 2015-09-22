module AskAwesomely
  class Choice

    def initialize(label:, picture: nil)
      @label = label
      @picture = picture && Picture.new(picture)
    end
    
  end
end
