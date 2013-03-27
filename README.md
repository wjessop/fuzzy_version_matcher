[![Build Status](https://travis-ci.org/wjessop/fuzzy_version_matcher.png?branch=master)](https://travis-ci.org/wjessop/fuzzy_version_matcher)

# FuzzyVersionMatcher

The Fuzzy Version Matcher gem takes a list of candidate version numbers (strings in the form of numbers/letters separated by non-numbers/letters) eg:

* 5.1.45-10-percona
* 5.1.45-10.2-percona
* 5.1.66-14.2-percona
* 5.1.67-14.3-percona
* 5.5.23-25.3-percona
* 5.5.27-29.0-percona
* 5.5.28-29.2-percona
* 5.5.29-29.4-percona

and a subject version number, eg:

5.1.45-10.3-maria

The gem will provide the "best match" version from the candidate list according to some simple rules:

* An exact match returns the same version string, eg:

	5.1.45-10-percona => 5.1.45-10-percona

* A partial match returns the highest version available from the partial match, eg:

	5.5 => 5.5.29-29.4-percona

* An inexact match matches as many of the most significant version segments as possible before matching the remaining version segments at the highest level, eg:

	5.1.66-15.5-percona => 5.1.66-14.2-percona

## Installation

Add this line to your application's Gemfile:

    gem 'fuzzy_version_matcher'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuzzy_version_matcher

I've tested the gem on 2.0.0, it probably works on 1.9.3. 1.8.7 YMMV.

## Usage

```ruby
n = FuzzyVersionMatcher::Node.new

DATA.readlines.each do |ln|
	# add all available versions
	n.add_node(ln.chomp)
end

puts n.search("5.5.27-29.0-percona") # 5.5.27-29.0-percona
puts n.search("5.1.45-10-percona") # 5.1.45-10-percona
puts n.search("5.1.45-10.2-percona") # 5.1.45-10.2-percona
puts n.search("5.1.45-10.2-maria") # 5.1.45-10.2-percona
puts n.search("5.1.45-10.400-percona") # 5.1.45-10.2-percona
puts n.search("5.5") # 5.5.29-30.0-percona

__END__
5.1.45-10-percona
5.1.45-10.2-percona
5.1.66-14.2-percona
5.1.67-14.3-percona
5.5.23-25.3-percona
5.5.27-29.0-percona
5.5.28-29.2-percona
5.5.29-29.4-percona
5.5.29-30.0-percona
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make sure the tests run
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
