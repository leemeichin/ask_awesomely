module AskAwesomely
  class Embeddable

    EMBED_TYPES = %i(
      modal
      drawer
      widget
      fullscreen
    )

    DEFAULT_OPTIONS = {
      width: 800,
      height: 600,
      button_text: "Launch me!"
    }

    def initialize(embed_type)
      unless EMBED_TYPES.include?(embed_type)
        raise AskAwesomely::EmbedTypeError, "embed type must be one of: #{EMBED_TYPES.join(', ')}"
      end

      @embed_type = embed_type
    end

    def render(typeform, options = {})
      locals = DEFAULT_OPTIONS
               .merge(options)
               .merge(public_url: typeform.public_url, title: typeform.title)
      Erubis::Eruby.new(template).result(locals)
    end

    private 

    def template
      Pathname.new(__dir__).join("embeds", "#{@embed_type}.erb").read
    end

  end
end
