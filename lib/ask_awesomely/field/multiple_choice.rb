module AskAwesomely
  class Field::MultipleChoice < Field::Field

    def initialize(*)
      super
      @state.choices = []
      @state.allow_multiple_selections = false
      @state.randomize = false
      @state.vertical_alignment = false
      @state.add_other_choice = false
    end

    def choice(label)
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
    
  end
end
