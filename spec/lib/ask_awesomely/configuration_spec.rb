require "spec_helper"
require "tempfile"


describe AskAwesomely::Configuration, "Typeform and optional AWS Config" do

  subject { AskAwesomely::Configuration.new }

  let(:tmp_file) { Tempfile.new(['test', '.jpg']) }
  let(:picture) { AskAwesomely::Picture.new(tmp_file) }
  let(:api_key) { "abcdefghi" }
  let(:secret) { "secret" }
  let(:region) { "outer-mongolia" }
  let(:bucket) { "ice-bucket" }

  after do
    tmp_file.close
  end

  describe "Typeform I/O" do
    it "should raise an error when no API key is supplied" do
      subject.typeform_api_key = nil

      proc {
        subject.typeform_api_key
      }.must_raise(AskAwesomely::ConfigurationError)
    end

    it "should not raise an error when an API key is supplied" do
      subject.typeform_api_key = api_key
      
      subject.typeform_api_key.must_equal(api_key)
    end
  end

  describe "AWS" do
    it "should allow AWS access keys to be configured" do
      subject.aws_access_key_id = api_key
      subject.aws_access_key_secret = secret

      subject.aws_access_key_id.must_equal(api_key)
      subject.aws_access_key_secret.must_equal(secret)
    end

    it "should allow a bucket name and location to be configured" do
      subject.aws_region = region
      subject.aws_bucket = bucket

      subject.aws_region.must_equal(region)
      subject.aws_bucket.must_equal(bucket)
    end

    it "should have a default bucket name and location" do
      subject.aws_region.must_equal(AskAwesomely::Configuration::DEFAULT_AWS_REGION)
      subject.aws_bucket.must_equal(AskAwesomely::Configuration::DEFAULT_AWS_BUCKET)
    end
  end
end
