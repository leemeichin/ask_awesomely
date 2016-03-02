module AskAwesomely
  class Field::OpinionScale < Field::Field

    POSSIBLE_STEPS = 5..11

    def steps(steps)
      unless POSSIBLE_STEPS.cover?(steps)
        raise ArgumentError, "number of steps must be between #{POSSIBLE_STEPS.begin} and #{POSSIBLE_STEPS.end}"
      end

      @state.steps = steps
    end

    def starts_from_one
      @state.start_at_one = true
    end

    def left_side(label)
      @state.label ||= Hash.new(nil)
      @state.label[:left_side] = label
    end

    def middle(label)
      @state.label ||= Hash.new(nil)
      @state.label[:center] = label
    end

    def right_side(label)
      @state.label ||= Hash.new(nil)
      @state.label[:right] = label
    end

  end
end
