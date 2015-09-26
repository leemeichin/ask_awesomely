require "spec_helper"

describe AskAwesomely::DSL, "The Typeform builder DSL" do

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

  before do
    AskAwesomely.configure do |config|
      config.typeform_api_key = "abcdefg"
    end

    # we don't care about requests in these tests
    Typhoeus.stub(AskAwesomely::ApiClient::BASE_URL).and_return(nil)
  end

  after do
    Typhoeus::Expectation.clear
  end

  describe "building a Typeform with static data" do
    subject { BasicForm }
    let(:json) { fixture("basic_form") }

    it "has a valid JSON representation when built" do
      form = subject.build
      
      generated_json = JSON.pretty_generate(JSON.parse(form.to_json))
      generated_json.must_equal(json)
    end
  end

end
