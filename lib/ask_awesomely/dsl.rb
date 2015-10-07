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

      def send_responses_to(url)
        unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
          raise AskAwesomely::InvalidUrlError, "you must use a valid URL for webhooks, e.g https://example.com/webhook"
        end
        
        _state.webhook_submit_url = url
      end
    end

    attr_reader :context, :json

    def build_json
      warn_if_no_webhook_set!
      
      state.to_h.reduce({}) do |json, (k, v)|
        json[k] = case
        when v.respond_to?(:to_ary) then v.map {|f| f.respond_to?(:build_json) ? f.build_json(context) : f }
        when v.respond_to?(:call) then v.call(context)
        when v.respond_to?(:build_json) then v.build_json(context)
        else
          v
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

    def warn_if_no_webhook_set!
      return if state.webhook_submit_url
      AskAwesomely.configuration.logger.warn(<<-STR.gsub(/^\s*/, ''))
        Your Typeform has no webhook URL! The responses to this form **will NOT** be saved!
        To set one, add `send_responses_to "https://example.com/webhook"` to #{self.class.name} 
      STR
    end
  end
end
