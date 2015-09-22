# Ask Awesomely

Build Typeforms awesomely. In Ruby.

**not yet functional**

## Installation

I wouldn't recommend you do this yet, because it doesn't actually work. Nevertheless, add this line to your application's Gemfile:

```ruby
gem 'ask_awesomely'
```

And then execute:

```shell
bundle
```

Or install it yourself as:

```shell
gem install ask_awesomely
```

## Usage & Example

Firstly, you will need to be able to authenticate:

```ruby
AskAwesomely.configure do |config|
  config.typeform_api_key = "YOUR_TYPEFORM_IO_API_KEY"
end
```

Your API Key is **super secret** so don't commit it in your code. Use `ENV` or
something like [dotenv](https://github.com/bkeepers/dotenv) so you can keep the credentials out of the repository. This stops bad people from stealing the key and hijacking your Typeform I/O account.

You will want to create a class that represents a specific form to be built:

```ruby
class MyNewTypeform

  include AskAwesomely


  typeform "My New Typeform" do
    tags "awesome", "hehe"

    field :statement do
      say "Hello, Rubyists!"
    end

    field :multiple_choice do
      ask "What is your favourite language?"
      choice "Ruby"
      choice "Python"
      choice "Javascript"
      choice "COBOL"

      can_specify_other
    end

  end

end
```

Check the rest of the (not currently finished) documentation to find out what else you can do.

Check out [Typeform I/O](https://typeform.io) for detailed information about the API, and how to get your API key.

## Available fields and options

Each field has unique properties. Here are the fields you can use, and the extra
things you can do to customise them.

<small> Note that some options might not yet be available on [Typeform I/O](https://typeform.io).</small>

<small>Also note that some field types and customisations that are available on [Typeform.com](https://typeform.com) may not be available on [Typeform I/O](https://typeform.io).</small>

### Statement

A block of text that isn't a question and requires no answer.

```ruby
field :statement do
  say "what you want to say"
  button_text "Okay, next question"
  show_quotation_marks
end
```

#### Short text

A question where the answer is a short amount of free-form text.

```ruby
field :short_text do
  ask "What do you think of me?"
  max_characters 3
end
```

### Long text

A question where the answer is free-form, like `short_text`, but can be *much* longer.

```ruby
field :long_text do
  ask "What do you *really* think of me?"
  max_characters 700
end
```

### Multiple choice

A question that allows the user to choose from a range answers.

```ruby
field :multiple_choice do
  ask "Why not both?"

  choice "Yes"
  choice "No"

  allow_multiple_selections
  randomize
end
```

### Picture choice

Similar to `multiple_choice`, only you can add a picture to each answer too. This will handle the complications around image uploading for you.

```ruby
field :picture_choice do
  ask "Which of these is a spoon?"

  # `image` can be a `String` or a `Pathname` or a `File`
  choice "Knife", picture: "path/to/your/spoon/image.jpg"
  choice "Sppon", picture: Rails.root.join("app/assets/images/image.jpg"

  allow_multiple_selections
  randomize
end
```

### Dropdown

Similar again to `multiple_choice`, when you have too many options to show at once.

```ruby
field :dropdown do
  ask "Which is the odd one out?"

  choice "1"
  choice "2"
  choice "3"
  choice "4"

  # ... many lines later

  choice "seventy"
  choice "71"
  choice "72"
  choice "73"

  in_alphabetical_order
end
```

### Yes/No

A question that demands the user to commit to their own certainty.

```ruby
field :yes_no do
  ask "Will you marry me?"
  required
end
```

### Number

A `short_text` style question that only accepts numerical input. It can be limited to a range.

```ruby
field :number do
  ask "How many fingers am I holding up?"

  min 0
  max 4

  # alternatively
  between 0..4
end
```

### Rating

A question that prompts the user to quantify their opinion of something.

```ruby
field :rating do
  ask "How much did you enjoy Jonny Wiseau's seminal hit, The Room?"

  steps 10
  shape :thumbs_up
end

```

### Opinion Scale

A refined form of `rating` more appropriate for "bad / neutral / good" style questions.

```ruby
field :opinion_scale do
  ask "How would you rate our service?"

  steps 11

  left_side "Terrible"
  middle "Average"
  right_side "Amazeballs"

  starts_from_one
end
```

### Email

A question type painstakingly created to request a valid email address.

```ruby
field :email do
  ask "Can I have your email please?"
  description "So you can be my best pen-pal buddy forever."
end
```

### Website

Ask the user to enter a valid URL.

```ruby
field :website do
  ask "Show me a funny GIF"
end
```

### Legal

![YAAAAWWWWN](https://31.media.tumblr.com/3a602d9eb5e18d208b86bc18c4ea0735/tumblr_ns3e06dxFO1tyncywo1_250.gif)

Like the `yes_no` field, but primarily intended for accepting terms and conditions. Stuff like that.

```ruby
field :legal
  ask "Do you accept my lofty demands?"
  required
end
```

------

#### Common Customisations

Every field type allows you customize the following things:

- the description: a smaller chunk of text to give extra detail to a question
- tags: small strings to help you identify questions
- answer required: prevent form submission until the question is answered

```ruby
field :legal do
  # ...
  description "Don't accept, I dare you."
  required
  tags "some-kind-of-tag-for-legal", "wtf"
end
```


## Todo

- tests, once the DSL looks like it makes sense
- actually build the form and submit it (you know, the reason for using this)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it (https://github.com/leemachin/ask_awesomely/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
