module AskAwesomely
  class Typeform
    attr_reader :links, :id, :structure, :fields

    def initialize(structure)
      @structure = structure
      @fields = []
    end

    def title
      @structure.class._state.title
    end

    def public_url
      @public_url ||= links.find do |link|
        link['rel'] == 'form_render'
      end.fetch('href')
    end

    def private_url
      @private_url ||= links.find do |link|
        link['rel'] == 'self'
      end.fetch('href')
    end

    def embed_as(type, options = {})
      Embeddable.new(type).render(self, options)
    end

    def update_with_api_response(response)
      @links = response['_links']
      @id = response['id']
      @fields = response['fields']
    end

    def to_json
      @structure.to_json
    end
  end
end
