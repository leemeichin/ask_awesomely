require "spec_helper"

describe AskAwesomely::DSL, "The Typeform builder DSL" do

  before do
    VCR.turn_off!
    # we don't care about requests in these tests
    Typhoeus.stub(AskAwesomely::ApiClient::BASE_URL).and_return(nil)
  end

  after do
    Typhoeus::Expectation.clear
    VCR.turn_on!
  end

  describe "building a Typeform with static data" do
    subject { BasicTypeform }
    let(:json) { fixture("basic_form") }

    it "has a valid JSON representation when built" do
      form = subject.build
      
      generated_json = JSON.pretty_generate(JSON.parse(form.to_json))
      generated_json.must_equal(json)
    end
  end

  describe "building a Typeform and passing in context" do
    subject { UserTypeform }

    let(:user) { { name: "Guillermo", email: "guillermo@example.com" } }
    let(:json) { fixture("user_form") }

    it "has a valid JSON representation when built" do
      form = subject.build(user)
      generated_json = JSON.pretty_generate(JSON.parse(form.to_json))
      generated_json.must_equal(json)
    end
  end

  describe "building a Typeform and using pictures" do
    subject { PictureTypeform }

    let(:json) { fixture("picture_form") }
    
    it "should replace an image file/url with an ID for Typeform" do
      form = subject.build
        
      generated_json = JSON.pretty_generate(JSON.parse(form.to_json))
      generated_json.must_equal(json)
    end
  end

  describe "webhook urls" do
    subject { BasicTypeform }
    let(:string_logger) { StringIO.new }

    before do
      AskAwesomely.configure do |config|
        config.logger = Logger.new(string_logger)
      end
    end
    
    it "raises an error when the URL isn't valid" do
      proc {
        subject.send_responses_to("nonsense-string.com")
      }.must_raise(AskAwesomely::InvalidUrlError)
    end

    it "warns you when building a form without a webhook URL" do
      subject.build
      string_logger.string.must_match(/Your Typeform has no webhook URL!/)
    end
  end

end
