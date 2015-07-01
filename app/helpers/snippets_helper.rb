module SnippetsHelper

	def total_snippet
		Snippet.all.count
	end
end
