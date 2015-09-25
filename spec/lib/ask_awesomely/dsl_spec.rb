require "spec_helper"

describe AskAwesomely::DSL, "The Typeform builder DSL" do

  EmptyForm = Class.new do
    include AskAwesomely::DSL
  end

  BasicForm = Class.new do
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


  describe "the top-level language for creating a Typeform" do

    subject { EmptyForm }

    it "can set the title of the form" do
      subject.title "Test Form"
      subject._state.title.must_equal "Test Form"
    end

    it "can add tags" do
      subject.tags "A", "B", "C"
      subject._state.tags.must_equal(["A", "B", "C"])
    end

    it "can add fields" do
      subject.field :statement do
        say "Something"
      end

      subject._state.fields.first.must_be_kind_of(AskAwesomely::Field::Statement)
    end
  end

  describe "building a Typeform with static data" do

    subject { BasicForm }
    let(:json) { fixture("basic_form") }

    it "has a valid JSON representation" do
      form = subject.build!
      generated_json = JSON.pretty_generate(JSON.parse(form.json))
      generated_json.must_equal(json)
    end
  end

end
