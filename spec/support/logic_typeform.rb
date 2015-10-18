class LogicTypeform
  include AskAwesomely::DSL

  title "My Example Form"

  tags "example", "logic-jumps"

  jump from: :shall_continue?, to: :shall_not_continue, if_answer: false

  field :yes_no do
    ask "Shall we continue?"
    ref :shall_continue?
  end

  field :statement do
    say "Thanks!"
  end

  field :statement do
    say "Wut?"
    ref :shall_not_continue
  end
end
