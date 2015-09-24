require "spec_helper"

describe AskAwesomely::DSL, "The Typeform builder DSL" do

  TestClass = Class.new do
    include AskAwesomely::DSL
  end

  subject { TestClass }

  describe "the top-level language for creating a Typeform" do
    it "can set the title of the form" do
      subject.must_respond_to :title
    end

    it "can add tags" do
      subject.must_respond_to :tags
    end

    it "can add fields" do
      subject.must_respond_to :field
    end
  end

end
