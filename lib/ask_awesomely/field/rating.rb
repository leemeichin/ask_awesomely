module AskAwesomely
  class Field::Rating < Field::Field

    POSSIBLE_STEPS = 3..10
    SHAPES = %i(
      stars
      thumbs_up
    )
    
    def initialize(*)
      super
    end

    def steps(steps)
      unless POSSIBLE_STEPS.cover?(steps)
        raise ArgumentError, "number of steps must be between #{POSSIBLE_STEPS.begin} and #{POSSIBLE_STEPS.end}"
      end

      @state.steps = steps
    end

    def shape(shape)
      unless SHAPES.include?(shape)
        raise ArgumentError, "shape must be one of: #{SHAPES.join(", ")}"
      end

      @state.shape = shape
    end
    
  end
end
