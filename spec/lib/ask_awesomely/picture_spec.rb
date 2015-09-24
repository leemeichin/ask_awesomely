require "spec_helper"
require "tempfile"

describe AskAwesomely::Picture, "Handling local/remote images" do

  subject { AskAwesomely::Picture }

  let(:fake_image) { Tempfile.new(['fake-image', '.jpg']) }
  let(:s3_url) {
    "https://s3.amazonaws.com/#{AskAwesomely::Configuration::DEFAULT_AWS_BUCKET}/"
  }

  before do
    AskAwesomely.configure do |config|
      config.aws_access_key_id = "abcde"
      config.aws_access_key_secret = "abcde"
    end
  end

  after do
    fake_image.close
  end

  describe "the picture's public URL" do
    describe "for a picture hosted on the internet" do
      it "just returns the URL supplied, as it doesn't need to do anything else" do
        picture = subject.new("https://imgur.com/abcdef")
        picture.public_url.must_equal("https://imgur.com/abcdef")
      end
    end

    describe "for a picture stored locally" do
      it "uploads the image to S3 and returns a new URL" do
        picture = subject.new(fake_image)
        picture.public_url.must_equal(s3_url + File.basename(fake_image))
      end
    end
  end

end
