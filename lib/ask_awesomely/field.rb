require "ask_awesomely/field/short_text"
require "ask_awesomely/field/long_text"
require "ask_awesomely/field/multiple_choice"
require "ask_awesomely/field/picture_choice"
require "ask_awesomely/field/statement"

module AskAwesomely
  class Field

    FieldTypeError = Class.new(TypeError)

    VALID_FIELD_TYPES = %i(
      short_text 
      long_text 
      multiple_choice 
      picture_choice 
      statement
    ).freeze

    
    def self.of_type(type, &block)
      case type
      when :short_text then Field::ShortText
      when :long_text then Field::LongText
      when :multiple_choice then Field::MultipleChoice
      when :picture_choice then Field::PictureChoice
      when :statement then Field::Statement
      else
        raise FieldTypeError, "This type of field does not exist, please use one of: #{VALID_FIELD_TYPES.join(", ")}"
      end
    end
    
    # Allow init with properties common to *all* fields
    def initialize(type, &block)
      @state = OpenStruct.new(
        body: "",
        description: "",
        required: false,
        tags: []
      )

      self.instance_eval(&block) if block_given?
    end

    def ask(body)
      @state.body = body
    end
    
    def required
      @state.required = true
    end
    
  end
end
