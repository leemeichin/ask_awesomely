module AskAwesomely
  module DSL

    def self.included(recv)
      recv.extend(ClassMethods)
      recv.include(JsonBuilder)
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

      def jump(conditions)
        _state.jumps ||= []
        _state.jumps << LogicJump.new(conditions)
      end

      def design(id = nil, &block)
        _state.design_id = id || ->(_) { Design.new(&block).id }
      end

      def no_branding
         _state.branding = false
      end

      def send_responses_to(url)
        unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
          raise AskAwesomely::InvalidUrlError, "you must use a valid URL for webhooks, e.g https://example.com/webhook"
        end

        _state.webhook_submit_url = url
      end
    end

    attr_reader :context, :json, :state

    def to_json
      warn_if_no_webhook_set
      build_json(context).to_json
    end

    private

    def initialize(context = nil)
      @context = context
      @state = self.class._state
    end

    def warn_if_no_webhook_set
      return if state.webhook_submit_url
      AskAwesomely.configuration.logger.warn(<<-STR.gsub(/^\s*/, ''))
        Your Typeform has no webhook URL! The responses to this form **will NOT** be saved!
        To set one, add `send_responses_to "https://example.com/webhook"` to #{self.class.name}
      STR
    end
  end
end
