module AskAwesomely
  class Field::ShortText < Field::Field

    def initialize(*)
      super
      @state.max_characters = nil
    end
    
    def max_characters(num)
      @state.max_characters = num
    end
    
  end
end
