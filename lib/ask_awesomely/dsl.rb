module AskAwesomely
  module DSL

    def self.included(recv)
      recv.extend(ClassMethods)
    end

    module ClassMethods
      def _api_client
        @api_client = ApiClient.new
      end

      def _state
        @state ||= OpenStruct.new(
          title: "",
          fields: []
        )
      end

      def build(context = nil)
        structure = new(context)
        typeform = Typeform.new(structure)
        _api_client.submit_typeform(typeform)
      end

      def title(title)
        _state.title = title
      end

      def tags(*tags)
        _state.tags = tags
      end

      def field(type, &block)
        _state.fields << Field::Field.of_type(type, &block)
      end
    end

    attr_reader :context, :json

    private def initialize(context = nil)
      @context = context
    end

    def to_json
      self.class._state.to_h.to_json
    end

  end
end
