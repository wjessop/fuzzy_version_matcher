require "fuzzy_version_matcher/version"

module FuzzyVersionMatcher
	class Node
		def initialize
			@nodes = {}
			@version = nil
			@segment = nil
		end

		def add_node(version_string, version_segments = nil)
			# If version_segments is nil we are the top node, create a version_segments array
			version_segments ||= string_to_segments(version_string)

			next_segment = version_segments.shift
			if version_segments.size == 0
				# We got to the last remaining version segment, we need to store the whole version string in this node
				@version = version_string
			else
				@nodes[next_segment] = self.class.new unless @nodes.has_key? next_segment
				@nodes[next_segment].add_node(version_string, version_segments)
			end
			@segment = next_segment
		end

		def search(version_string, version_segments = nil)
			# If version_segments is nil we are the top node, create a version_segments array
			version_segments ||= string_to_segments(version_string)

			next_segment = version_segments.shift
			if @nodes.has_key? next_segment
				@nodes[next_segment].search(version_string, version_segments)
			else
				return (!@version.nil? && version_segments.size == 0) ? @version : traverse_high
			end
		end

		protected

		def traverse_high
			if @nodes.size > 0
				return @nodes.sort_by{|seg| seg}.last.last.traverse_high || @version
			else
				return @version
			end
		end

		private

		def string_to_segments(version_string)
			version_string.split(/[^a-zA-Z0-9]/)
		end
	end
end
