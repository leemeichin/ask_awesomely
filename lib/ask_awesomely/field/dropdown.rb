module AskAwesomely
  class Field::Dropdown < Field::Field

    def choice(label)
      @state.choices ||= []
      @state.choices << Choice.new(label: label)
    end

    def in_alphabetical_order
      @state.alphabetical_order = true
    end

  end
end
