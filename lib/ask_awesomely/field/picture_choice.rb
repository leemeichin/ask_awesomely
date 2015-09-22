module AskAwesomely
  class Field::PictureChoice < Field

    def initialize(*)
      super
      @state.choices = []
      @state.labels = true
      @state.allow_multiple_selections = false
      @state.randomize = false
      @state.vertical_alignment = false
      @state.add_other_choice = false
    end

    def choice(label, picture_id:)
      @state.choices << Choice.new(label: label, picture_id: picture_id)
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

    def hide_labels
      @state.labels = false
    end
    
  end
end
