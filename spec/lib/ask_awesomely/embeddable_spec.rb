require "spec_helper"

describe AskAwesomely::Embeddable, "embed strings for forms" do

  subject { AskAwesomely::Embeddable }

  let(:typeform) { AskAwesomely::Typeform.new(BasicTypeform.new) }

  before do
    typeform.instance_variable_set(:@public_url, "http://typeform.io/to/aBcDeF")
  end

  describe "invalid type" do
    it "should raise an error if the embed type doesn't exist" do
      proc {
        subject.new(:lol_type)
      }.must_raise(AskAwesomely::EmbedTypeError)
    end
  end
  
  describe "modal" do
    it "should return the modal embed string with the correct URL" do
      embed = subject.new(:modal)
      embed.render(typeform).must_match(typeform.public_url)
    end
  end

  describe "fullscreen" do
    it "should return the fullscreen embed string with the correct URL" do
      embed = subject.new(:fullscreen)
      embed.render(typeform).must_match(typeform.public_url)
    end
  end

  describe "widget" do
    it "should return the widget embed string with the correct URL and title" do
      embed = subject.new(:widget)
      widget = embed.render(typeform)

      widget.must_match(typeform.public_url)
      widget.must_match(typeform.title)
    end
  end

  describe "drawer" do
    it "should return the drawer embed string with the correct URL" do
      embed = subject.new(:drawer)
      embed.render(typeform).must_match(typeform.public_url)
    end
  end
end
