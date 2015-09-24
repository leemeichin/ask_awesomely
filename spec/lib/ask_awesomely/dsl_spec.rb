require "spec_helper"

describe AskAwesomely::DSL, "The Typeform builder DSL" do

  TestClass = Class.new do
    include AskAwesomely::DSL
  end

  subject { TestClass }

  describe "the top-level language for creating a Typeform" do
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

end
