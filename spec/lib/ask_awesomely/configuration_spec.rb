require "spec_helper"
require "tempfile"


describe AskAwesomely::Configuration, "Typeform and optional AWS Config" do

  subject { AskAwesomely::Configuration.new }

  let(:tmp_file) { Tempfile.new(['test', '.jpg']) }
  let(:picture) { AskAwesomely::Picture.new(tmp_file) }

  after do
    tmp_file.close
  end

  describe "when keys are not supplied" do
    it "should always raise an error for Typeform I/O" do
      proc {
        subject.typeform_api_key
      }.must_raise(AskAwesomely::ConfigurationError)
    end

    it "should only raise an error for AWS when dealing with images" do
      proc {
        picture.public_url
      }.must_raise(AskAwesomely::ConfigurationError)
    end
  end
end
