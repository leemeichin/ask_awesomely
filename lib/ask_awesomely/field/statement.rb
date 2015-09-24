module AskAwesomely
  class Field::Statement < Field::Field

    def initialize(*)
      super
      @state.button_text = "Continue"
      @state.has_marks = false
    end

    def say(text)
      @state.body = text
    end
    
    def show_quotation_marks
      @state.has_marks = true
    end

    def button_text(text)
      @state.button_text = text
    end
    
  end
end
