require "ask_awesomely/field/short_text"
require "ask_awesomely/field/long_text"
require "ask_awesomely/field/multiple_choice"
require "ask_awesomely/field/picture_choice"
require "ask_awesomely/field/statement"
require "ask_awesomely/field/number"
require "ask_awesomely/field/dropdown"
require "ask_awesomely/field/yes_no"
require "ask_awesomely/field/rating"
require "ask_awesomely/field/opinion_scale"
require "ask_awesomely/field/email"
require "ask_awesomely/field/website"
require "ask_awesomely/field/legal"

module AskAwesomely
  class Field

    FieldTypeError = Class.new(TypeError)

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

    # todo: make this easier to maintain
    def self.of_type(type, &block)
      field = case type
      when :short_text then Field::ShortText
      when :long_text then Field::LongText
      when :multiple_choice then Field::MultipleChoice
      when :picture_choice then Field::PictureChoice
      when :statement then Field::Statement
      when :dropdown then Field::Dropdown
      when :yes_no then Field::YesNo
      when :number then Field::Number
      when :rating then Field::Rating
      when :opinion_scale then Field::OpinionScale
      when :email then Field::Email
      when :website then Field::Website
      when :legal then Field::Legal
      else
        raise FieldTypeError, "This type of field does not exist, please use one of: #{VALID_FIELD_TYPES.join(", ")}"
      end

      field.new(type, &block)
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
