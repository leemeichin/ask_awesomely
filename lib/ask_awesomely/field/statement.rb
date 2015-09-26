module AskAwesomely
  class Field::Statement < Field::Field

    def initialize(*)
      super
    end

    def say(statement)
      @state.question = statement
    end
    
    def show_quotation_marks
      @state.has_marks = true
    end

    def button_text(text)
      @state.button_text = text
    end
    
  end
end
