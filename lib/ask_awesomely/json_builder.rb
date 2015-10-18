module AskAwesomely
  module JsonBuilder
    
    def build_json(context = nil)
      state.to_h.reduce({}) do |json, (k, v)|
        json[k] = case 
                  when v.respond_to?(:to_ary)
                    v.map {|f| f.respond_to?(:build_json) ? f.build_json(context) : f }
                  when v.respond_to?(:call)
                    v.call(context)
                  when v.respond_to?(:build_json)
                    v.build_json(context)
                  else
                    v
                  end
        json
      end
    end
    
  end
end
