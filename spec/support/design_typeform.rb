class DesignTypeform
  include AskAwesomely::DSL

  title "Design Typeform"

  tags "example", "with-design"

  design do
    background_color "#ff0033"
    answer_color "#3300ff"
    question_color "#ff3300"
    button_color "#00ff33"

    font "Vollkorn"
  end

  field :statement do
    say "I am just a test"
  end

end
