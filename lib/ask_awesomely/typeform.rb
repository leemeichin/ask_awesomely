module AskAwesomely
  module Typeform

    def typeform(&block)
      _build_typeform(title, &block)
    end

    private

    def _build_typeform(title)
      @_typeform ||= Builder.new(title)
    end
    
  end
end
