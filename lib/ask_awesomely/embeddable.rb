module AskAwesomely
  class Embeddable

    EMBED_TYPES = %i(
      modal
      drawer
      widget
      fullscreen
    )

    def initialize(embed_type)
      unless EMBED_TYPES.include?(embed_type)
        raise AskAwesomely::EmbedTypeError, "embed type must be one of: #{EMBED_TYPES.join(', ')}"
      end

      @embed_type = embed_type
    end

    def render(typeform)
      ERB.new(template, 0, '>').result(typeform.get_binding)
    end

    private 

    def template
      Pathname.new(__dir__).join("embeds", "#{@embed_type}.erb").read
    end

  end
end
