$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'ask_awesomely'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

Aws.config.update({
  stub_responses: true
})

def fixture(name)
  Pathname.new(__dir__).join("fixtures", "#{name}.json").read.chomp
end
