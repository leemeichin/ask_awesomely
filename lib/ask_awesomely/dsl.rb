module AskAwesomely
  module DSL
    
    def self.included(recv)
      recv.extend(ClassMethods)
    end

    module ClassMethods
      class << self
        def _state
          @state ||= OpenStruct.new(
            title: "",
            fields: [],
            tags: []
          )
        end

        def build!(context = nil)
          new(context).tap(&:build!)
        end
        
        def title(title)
          _state.title = title
        end
      
        def tags(*tags)
          _state.tags = tags
        end

        def field(type:, body:, &block)
          _state.fields << Field.of_type(type, &block)
        end
      end
    end

    attr_reader :context
    
    def initialize(context = nil)
      @context = context
    end

    private
    
    def build!
      # send off to API
    end
  end
end
