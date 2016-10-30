module AskAwesomely
  class Field::Statement < Field::Field

    def initialize(*)
      super
    end

    def no_quotation_marks
      @state.hide_marks = true
    end

    def button_text(text)
      @state.button_text = text
    end

  end
end
