require 'minitest_helper'

class TestFuzzyVersionMatcher < MiniTest::Unit::TestCase
	def setup
		@matcher = FuzzyVersionMatcher::Node.new
		%w{5.1.45-10-percona
		5.1.45-10.2-percona
		5.1.66-14.2-percona
		5.1.67-14.3-percona
		5.5.23-25.3-percona
		5.5.27-29.0-percona
		5.5.28-29.2-percona
		5.5.29-29.4-percona}.each {|v| @matcher.add_node(v)}
	end

	def test_that_it_has_a_version_number
		refute_nil ::FuzzyVersionMatcher::VERSION
	end

	def test_it_matches_exact_versions
		assert_equal @matcher.search("5.1.45-10-percona"), "5.1.45-10-percona"
	end

	def test_it_returns_highest_version_after_most_significant_match
		assert_equal @matcher.search("5.5"), "5.5.29-29.4-percona"
	end

	def test_inexact_match_matches_most_significant_segments_then_matches_high
		assert_equal @matcher.search("5.1.66-15.5-maria"), "5.1.66-14.2-percona"
	end
end
