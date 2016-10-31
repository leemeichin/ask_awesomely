module AskAwesomely
  class Field::Rating < Field::Field

    POSSIBLE_STEPS = 1..10
    VALID_SHAPES = [
      "star",
      "heart",
      "user",
      "up",
      "crown",
      "cat",
      "dog",
      "circle",
      "flag",
      "droplet",
      "tick",
      "lightbulb",
      "trophy",
      "cloud",
      "thunderbolt",
      "pencil",
      "skull"
    ]
    
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
      unless VALID_SHAPES.include?(shape)
        raise ArgumentError, "shape must be one of: #{VALID_SHAPES.join(", ")}"
      end

      @state.shape = shape
    end
    
  end
end
