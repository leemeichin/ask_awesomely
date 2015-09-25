module AskAwesomely
  module DSL
    
    def self.included(recv)
      recv.extend(ClassMethods)
    end

    module ClassMethods
      def _state
        @state ||= OpenStruct.new(
          title: "",
          fields: [],
          tags: []
        )
      end

      def build!(context = nil)
        new(context).tap(&:to_json)
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
    
    def initialize(context = nil)
      @context = context
    end

    def to_json
      @json = self.class._state.to_h.to_json
    end

  end
end
