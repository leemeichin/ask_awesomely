$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "ask_awesomely"
require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"
require "vcr"
require "pry"
require "pry-byebug"

Dir.glob("#{__dir__}/support/**/*.rb", &method(:require))

Aws.config.update({
  stub_responses: true
})

VCR.configure do |config|
  config.cassette_library_dir = "#{__dir__}/fixtures/vcr_cassettes"
  config.hook_into :typhoeus
  config.filter_sensitive_data('<API-KEY>') do |http|
    AskAwesomely.configuration.typeform_api_key
  end
end

AskAwesomely.configure do |config|
  config.typeform_api_key = ENV.fetch("TYPEFORM_IO_API_KEY", "fake_api_key")
end

def fixture(name)
  Pathname.new(__dir__).join("fixtures", "#{name}.json").read.chomp
end
