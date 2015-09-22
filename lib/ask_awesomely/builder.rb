module AskAwesomely
  class Builder

    attr_reader :state

    def initialize(title, &block)
      @state = OpenStruct.new(
        title: title,
        fields: [],
        tags: []
      )

      self.instance_eval(&block) if block_given?
    end

    def tags(*tags)
      @state.tags = tags
    end

    def field(type:, body:, &block)
      field = Field.of_type(type, &block)

      @state.fields << field
    end

  end
end
