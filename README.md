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

Note that some options might not yet be available on [Typeform I/O](https://typeform.io).

Also note that some field types and customisations that are available on [Typeform.com](https://typeform.com) may not be available on [Typeform I/O](https://typeform.io).

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
