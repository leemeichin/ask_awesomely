module AskAwesomely
  class Field::Field

    prepend JsonBuilder

    VALID_FIELD_TYPES = %i(
      short_text
      long_text
      multiple_choice
      picture_choice
      statement
      dropdown
      yes_no
      number
      rating
      opinion_scale
      email
      website
      legal
    ).freeze

    attr_reader :state

    def self.of_type(type, &block)
      field_type = type.to_s.split('_').map(&:capitalize).join
      field = AskAwesomely::Field.const_get(field_type)
      field.new(type, &block)
    rescue NameError
        raise FieldTypeError, "Field #{type} <#{field}> does not exist, please use one of: #{VALID_FIELD_TYPES.join(", ")}"
    end

    # Allow init with properties common to *all* fields
    def initialize(type, &block)
      @state = OpenStruct.new(type: type)

      self.instance_eval(&block) if block_given?
    end

    def ask(question)
      @state.question = question
    end

    def required
      @state.required = true
    end

    def tags(*tags)
      @state.tags = tags
    end

    def ref(name)
      @state.ref = name.to_s
    end

    def skip(condition)
      if condition[:if]
        cond_if = condition[:if]
        @state.skip = -> (context) { cond_if.call(context) == true }
      end

      if condition[:unless]
        cond_unless = condition[:unless]
        @state.skip = -> (context) { cond_unless.call(context) != true }
      end
    end
  end
end
