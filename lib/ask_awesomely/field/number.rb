module AskAwesomely
  class Field::Number < Field::Field

    def initialize(*)
      super
    end

    def min(min)
      @state.min_value = min
    end

    def max(max)
      @state.max_value = max
    end

    def between(range)
      min(range.begin)
      max(range.end)
    end
      
  end
end
