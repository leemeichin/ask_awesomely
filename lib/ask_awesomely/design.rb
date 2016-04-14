module AskAwesomely
  class Design

    VALID_FONTS = [
      "Acme",
      "Arial",
      "Arvo",
      "Bangers",
      "Cabin",
      "Cabin Condensed",
      "Courier",
      "Crete Round",
      "Dancing Script",
      "Exo",
      "Georgia",
      "Handlee",
      "Karla",
      "Lato",
      "Lobster",
      "Lora",
      "McLaren",
      "Monsterrat",
      "Nixie",
      "Old Standard TT",
      "Open Sans",
      "Oswald",
      "Playfair",
      "Quicksand",
      "Raleway",
      "Signika",
      "Sniglet",
      "Source Sans Pro",
      "Vollkorn"
    ]

    def initialize(&block)
      @state = OpenStruct.new(colors: {})
      instance_eval(&block)
    end

    def id
      @id ||= upload_to_typeform["id"]
    end

    def background_color(color)
      @state.colors[:background] = color
    end

    def question_color(color)
      @state.colors[:question] = color
    end

    def answer_color(color)
      @state.colors[:answer] = color
    end

    def button_color(color)
      @state.colors[:button] = color
    end

    def font(font)
      unless VALID_FONTS.include?(font)
          raise AskAwesomely::InvalidFontError, "#{font} is not supported; you must use one of the following fonts: #{VALID_FONTS.join(', ')}"
      end

      @state.font = font
    end

    def to_json(*)
      {
        colors: @state.colors,
        font: @state.font
      }.to_json
    end

    private

    def upload_to_typeform
        ApiClient.new.submit_design(self)
    end

  end
end
