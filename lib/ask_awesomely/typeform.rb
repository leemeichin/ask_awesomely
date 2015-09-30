module AskAwesomely
  class Typeform

    attr_reader :links, :id, :structure

    def initialize(structure)
      @structure = structure
    end

    def title
      @structure.class._state.title
    end
    
    def public_url
      @public_url ||= links.find {|link|
        link["rel"] == "form_render"
      }.fetch("href")
    end

    def private_url
      @private_url ||= links.find {|link|
        link["rel"] == "self"
      }.fetch("href")
    end

    def embed_as(type, options = {})
      Embeddable.new(type, options).render(self, options)
    end

    def update_with_api_response(response)
      @links = response["_links"]
      @id = response["id"]
    end

    def to_json
      @structure.build_json
    end

  end
end
