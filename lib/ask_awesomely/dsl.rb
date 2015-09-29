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

    def build_json
      state.to_h.reduce({}) do |json, (k, v)|
        json[k] = case k
        when :title, :tags
          v.respond_to?(:call) ? v.call(@context) : v
        when :fields
          v.map {|f| f.build_json(@context) }
        end

        json
      end.to_json
    end

    private
    
    def initialize(context = nil)
      @context = context
    end

    def state
      self.class._state
    end

  end
end
