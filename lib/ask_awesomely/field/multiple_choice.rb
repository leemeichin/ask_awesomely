module AskAwesomely
  class Field::MultipleChoice < Field::Field

    def choice(label)
      @state.choices ||= []
      @state.choices << Choice.new(label: label)
    end

    def allow_multiple_selections
      @state.allow_multiple_selections = true
    end

    def randomize
      @state.randomize = true
    end

    def can_specify_other
      @state.add_other_choice = true
    end

    def align_vertically
      @state.vertical_alignment = true
    end

  end
end
