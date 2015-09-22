module AskAwesomely
  class Field::Dropdown < Field

    def initialize(*)
      super
      @state.alphabetical_order = false
      @state.choices = []
    end

    def choice(label)
      @state.choices << Choice.new(label: label)
    end

    def in_alphabetical_order
      @state.alphabetical_order = true
    end
    
  end
end
