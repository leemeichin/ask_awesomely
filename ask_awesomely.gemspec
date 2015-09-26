# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ask_awesomely/version'

Gem::Specification.new do |spec|
  spec.name          = "ask_awesomely"
  spec.version       = AskAwesomely::VERSION
  spec.authors       = ["Lee Machin"]
  spec.email         = ["me@mrl.ee"]

  spec.summary       = "Create Typeforms on the fly, the Typeform way."
  spec.homepage      = "https://github.com/leemachin/ask_awesomely"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 2.0"
  spec.add_dependency "typhoeus", "~> 0.8"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
end
