class BasicTypeform
  include AskAwesomely::DSL

  title "My Example Form"

  tags "example", "first-attempt"

  field :statement do
    say "This is a test!"
  end

  field :short_text do
    ask "What do you think?"
    required
    tags "opinion"
  end
end
