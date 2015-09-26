module AskAwesomely
  class Field::LongText < Field::Field

    def max_characters(num)
      @state.max_characters = num
    end
    
  end
end
