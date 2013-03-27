# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuzzy_version_matcher/version'

Gem::Specification.new do |spec|
  spec.name          = "fuzzy_version_matcher"
  spec.version       = FuzzyVersionMatcher::VERSION
  spec.authors       = ["Will Jessop"]
  spec.email         = ["will@willj.net"]
  spec.description   = %q{Does a 'best match' of a version against a list of candiate version numbers}
  spec.summary       = %q{The Fuzzy Version Matcher gem takes a list of candidate version numbers and a subject version number and provides the "best match" version from the candidate list according to some simple rules}
  spec.homepage      = "https://github.com/wjessop/fuzzy_version_matcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
