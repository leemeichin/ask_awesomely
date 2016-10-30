module AskAwesomely
  class Field::PictureChoice < Field::Field

    def choice(label, picture:)
      @state.choices ||= []
      @state.choices << Choice.new(label: label, picture: picture)
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

    def show_labels
      @state.show_labels = true
    end

    def align_vertically
      @state.vertical_alignment = true
    end

  end
end
