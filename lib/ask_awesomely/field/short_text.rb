module AskAwesomely
  class Field::ShortText < Field::Field

    def max_characters(num)
      @state.max_characters = num
    end
    
  end
end
