module AskAwesomely
  class Field::Number < Field::Field

    def initialize(*)
      super
      @state.min = nil
      @state.max = nil
    end

    def min(min)
      @state.min = min
    end

    def max(max)
      @state.max = max
    end

    def between(range)
      min(range.begin)
      max(range.end)
    end
      
  end
end
