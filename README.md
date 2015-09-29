# Ask Awesomely

Build Typeforms awesomely. In Ruby.

[![Gem Version](https://badge.fury.io/rb/ask_awesomely.svg)](http://badge.fury.io/rb/ask_awesomely) [![Build Status](https://travis-ci.org/leemachin/ask_awesomely.svg?branch=master)](https://travis-ci.org/leemachin/ask_awesomely)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Before you start](#before-you-start)
- [Installation](#installation)
- [Usage](#usage)
  - [Authentication](#authentication)
  - [If you're using images](#if-youre-using-images)
  - [Logging](#logging)
  - [Basic example](#basic-example)
- [Available fields and options](#available-fields-and-options)
  - [Statement](#statement)
  - [Short text](#short-text)
  - [Long text](#long-text)
  - [Multiple choice](#multiple-choice)
  - [Picture choice](#picture-choice)
  - [Dropdown](#dropdown)
  - [Yes/No](#yesno)
  - [Number](#number)
  - [Rating](#rating)
  - [Opinion Scale](#opinion-scale)
  - [Email](#email)
  - [Website](#website)
  - [Legal](#legal)
- [Common Customisations](#common-customisations)
- [Passing Context](#passing-context)
- [Rendering the Typeform](#rendering-the-typeform)
  - [Getting the URL](#getting-the-url)
  - [Embedding](#embedding)
    - [Modal](#modal)
    - [Widget](#widget)
    - [Drawer](#drawer)
    - [Fullscreen](#fullscreen)
- [Getting Results](#getting-results)
- [Development](#development)
- [Feedback and Contributions](#feedback-and-contributions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Before you start


## Installation

Prepare your best [Jamie Oliver](https://en.wikipedia.org/wiki/Jamie_Oliver) impression and bang this in yer Gemfile:

```ruby
gem 'ask_awesomely'
```

Turn your CPU up to 80ºC and let it simmer for a while with this:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install ask_awesomely
```

Then include it in your code like this:

```ruby
require "ask_awesomely"
```

## Usage

### Authentication

Firstly, you will need to be able to authenticate:

```ruby
AskAwesomely.configure do |config|
  config.typeform_api_key = ENV["YOUR_TYPEFORM_IO_API_KEY"]
end
```

Your API Keys are **super secret** so don't commit them in your code. Use `ENV` or
something like [dotenv](https://github.com/bkeepers/dotenv) so you can keep the credentials out of the repository. This stops bad people from stealing the key and hijacking your Typeform I/O account.

### If you're using images

It's possible to create questions that have images (or pictures, as we call them) attached. In fact, one field type relies on this!

Currently Typeform I/O is only able to accept a URL to an image, which means that any images you use have to be uploaded elsewhere first.

**If you already handle image uploads in your app** (for example, with [Dragonfly](https://github.com/markevans/dragonfly)), you're okay.

**If you don't**, you will need to give `AskAwesomely` your AWS credentials so it can do all of the heavy lifting for you.

```ruby
AskAwesomely.configure do |config|
  config.aws_access_key_id = ENV["YOUR_AWS_ACCESS_KEY_ID"]
  config.aws_access_key_secret = ENV["YOUR_AWS_ACCESS_KEY_SECRET"]
end
```

As before, don't commit these keys to your repo unless you want [bad things to happen](http://vertis.io/2013/12/16/unauthorised-litecoin-mining.html). Check up on the [AWS Best Practices](http://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html) if you want to know more.

### Logging

`AskAwesomely` might warn you if you miss something out, just to make sure. By default this will go straight to `STDOUT`, but you can tell it to use your own logging:

```ruby
AskAwesomely.configure do |config|
  config.logger = your_new_logger
end
```

### Basic example

You will want to create a class that represents a specific form to be built:

```ruby
class MyNewTypeform

  include AskAwesomely::DSL

  title "My New Typeform"

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
```

After that, it's simply a matter of calling `build` on the class:

```ruby
typeform = MyNewTypeform.build
```

Check out [Typeform I/O](https://typeform.io) for detailed information about the API, and how to get your API key.


## Available fields and options

Each field has unique properties. Here are the fields you can use, and the extra
things you can do to customise them.

<small>Note that some options might not yet be available on [Typeform I/O](https://typeform.io).</small>

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

### Short text

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

Similar to `multiple_choice`, only you can add a picture to each answer too. This will handle the complications around image uploading for you if you're dealing with local files and pass along your AWS credentials. Otherwise, it will work with whatever system you already have in place – just give it a URL instead of a file path.


```ruby
field :picture_choice do
  ask "Which of these is a spoon?"

  # `image` can be a `String`, a `URL`, a `Pathname`, or a `File`
  choice "Knife", picture: "http://iseeyouveplayedknifeyspooneybefore.com/spoon.jpg"
  choice "Spoon", picture: Rails.root.join("app/assets/images/knife.jpg")
  choice "Spork", picture: "/var/www/images/spork.png"

  allow_multiple_selections
  randomize
end
```

### Dropdown

Similar again to `multiple_choice`, when you have too many options to show at once.

```ruby
field :dropdown do
  ask "Which is the odd one out?"


  (1..100).each do |number|
    choice (number != 70 ? number : "seventy")
  end

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


## Common Customisations

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

## Passing Context

Building a form full of hard-coded data is all well and good, but it doesn't offer much benefit over using a web interface. What if you want to build personalised forms based on, say, an `ActiveRecord` model?

Lets create the basic form, with a title and a single question:

```ruby
class UserTypeform
  include AskAwesomely::DSL

  title -> (user) { "#{user.name}'s New Typeform" }

  field :yes_no do
    say -> (user) { "Is this your email address? #{user.email}" }
    required
  end
end
```

Notice that we're now using a lambda for the title and question, instead of a hardcoded string. In this case, we're expecting an object that has a `name` and an `email`, so we can inject that data into the form.

The next step is to build the form with such an object. For example, in Rails:

```ruby
rodrigo = User.create(name: "Rodrigo", email: "rodrigo@example.com")

typeform = UserTypeform.build(rodrigo)
```

Or in plain Ruby:

```ruby
gabriela = OpenStruct.new(name: "Gabriela", email: "gabriela@example.com")

typeform = UserTypeform.build(gabriela)
```


## Rendering the Typeform

Calling `build` will send your Typeform structure to the API right away, and if everything is hunky-dory you'll get a nice new `Typeform` object to play with.

### Getting the URL

Every Typeform you successfully generate through Typeform I/O will come back with a new public URL. This points to the rendered version of the Typeform and it's what you can send out to your users, or participants, or whomever.

For example, you might email a bunch of personalised Typeforms in a Rails app like this:

```ruby

User.find_each do |user|
  typeform = UserTypeform.build(user)
  TypeformMailer.send_to_user(user, typeform.public_url)
end
```

### Embedding

You can also embed a form straight away if you prefer. `AskAwesomely` generates the correct embed code for you, with the correct URL and Typeform title. The style can be customised with CSS but some aspects of the embed itself are not currently customisable (e.g. changing button text and widget size).

To see what each embedding option looks like, check out the [`Embedding Modes`](http://docs.typeform.io/docs/embedding-introduction) documentation at Typeform I/O. It has pictures and everything.

Assuming you have built a Typeform as in the other examples, rendering the embed code is simple:

#### Modal

Pops up over the page content and fills most of the screen.

```ruby
typeform.embed_as(:modal)
```

#### Widget

Allows you more control over where the form is embedded and how it appears. Just a box on the page.

```ruby
typeform.embed_as(:widget)
```

#### Drawer

Makes the form slide in from the side of the page, hamburger menu style, and fills at least half of the screen.

```ruby
typeform.embed_as(:drawer)
```

#### Fullscreen

Becomes the entire page.

Note that this outputs a **complete** HTML document, CSS and all. If you're working with your own views and layouts this will not embed properly unless inserted into an empty layout. Can work well with Sinatra or other small frameworks if you just want to build a form and display it.

```ruby
typeform.embed_as(:fullscreen)
```

## Getting Results

Typeform I/O uses webhooks to send you the responses to your Typeforms. You can configure the URL by telling it where to send responses to, like this:

```ruby
class UserTypeform

  # all the fields ...

  send_responses_to "https://www.my-awesome-website.com/webhooks"
end
```

`AskAwesomely` will warn you if you don't configure this, as Typeform I/O doesn't store the responses for you and they'll be lost in the either.

Check the documentation on [results and webhooks](http://docs.typeform.io/docs/results-introduction) to find out more about how this works, what happens when a webhook submission request fails, and how you can deduplicate your submissions.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Feedback and Contributions

Practically every aspect of this gem (save for image uploading) is an extension of the Typeform I/O API. If the API has it, `AskAwesomely` eventually will. Here's what the Typeform I/O peeps say:

> We are continuously working on and improving Typeform I/O, and we're heavily focused on making the API as simple as possible, but also feature-rich so you can make good use of it. We would be forever grateful if you can leave us feedback. We welcome all questions, and we'd love to talk to you about how you're using Typeform I/O, what you hope for from us in the future, or anything else!

> We recommend you join our [#Slack group](http://docs.typeform.io/v0.4/page/slack-invite) to chat with us, and with other people using Typeform I/O. You can also ask us questions in our [Q&A section](http://docs.typeform.io/v0.4/discuss), or you can simply send us an email to [support@typeform.io](mailto:support@typeform.io).

That doesn't preclude contributing to the gem itself by fixing bugs or offering improvements. If you'd like to do that, follow these simple steps:

1. Fork it (https://github.com/leemachin/ask_awesomely/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
