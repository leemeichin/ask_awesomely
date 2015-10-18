module AskAwesomely
  class LogicJump

    include JsonBuilder

    attr_reader :state

    def initialize(args)
      @state = OpenStruct.new(
        to: args[:to],
        from: args[:from],
        if_answer: args[:if_answer]
      )
    end
    
  end
end
