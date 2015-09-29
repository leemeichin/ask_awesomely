module AskAwesomely
  class Field::Field

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
    
    def build_json(context = nil)
      state.to_h.reduce({}) do |json, (k, v)|
        json[k] = v.respond_to?(:call) ? v.call(context) : v
        json
      end
    end
    
  end
end
