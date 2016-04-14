module AskAwesomely
  class LogicJump

    include JsonBuilder

    attr_reader :state

    def initialize(args)
      @state = OpenStruct.new(
        to: args[:to],
        from: args[:from],
	if: args.key?(:if) ? args[:if] : args[:if_answer]
      )
    end

  end
end
