class UserTypeform
  include AskAwesomely::DSL

  title -> (user) { "#{user[:name]}'s Typeform" } 

  tags "example", "with-context"

  field :statement do
    say -> (user) { "Hello, #{user[:name]}!" }
  end

  field :yes_no do
    ask -> (user) {"Is your email address '#{user[:email]}'?" }
    required
  end
end
