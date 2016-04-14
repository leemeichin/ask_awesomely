class MultipleChoiceTypeform
  include AskAwesomely::DSL

  title "My Example Form"

  tags "example", "multiple-choice"

  field :multiple_choice do
    ask "What do you think?"

    choice "One"
    choice ->(two) { two }
    choice "Three"

    required
  end
end
