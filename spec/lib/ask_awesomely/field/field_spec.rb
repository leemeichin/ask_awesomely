require "spec_helper"

describe AskAwesomely::Field::Field, "A generic Field" do

  subject { AskAwesomely::Field::Field }

  describe "the options available to all field types" do

    it "must be able to define the field type" do
      field = subject.new(:fake)
      field.state.type.must_equal(:fake)
    end

    it "must be able to ask a question" do
        field = subject.new :fake do
          ask "A question"
        end

        field.state.question.must_equal("A question")
    end

    it "is optional by default" do
      field = subject.new(:fake)
      field.state.required.must_equal(nil)
    end

    it "must be able to be marked as required" do
      field = subject.new(:fake) do
        required
      end

      field.state.required.must_equal(true)
    end

    it "must be able to have tags" do
      field = subject.new(:fake) do
        tags "a", "b", "c"
      end

      field.state.tags.must_equal(["a", "b", "c"])
    end
    
  end
  
end
