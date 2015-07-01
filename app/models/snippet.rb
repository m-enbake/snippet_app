class Snippet < ActiveRecord::Base

	validates :snippet_text, presence: true, length: { maximum: 8192 }
	self.per_page = 20

	before_save :create_secure_slug 


	def create_secure_slug
		if self.slug.blank?
	      slug = SecureRandom.hex(8).downcase
	      @collision = Snippet.find_by_slug(slug)

	      while !@collision.nil?
	        slug = SecureRandom.hex(8).upcase
	      @collision = Spree::Variant.find_by_slug(slug)
	      end
	      self.slug = slug
	    end
	end

	def share_url
		self.private? ? "snippets/private/#{self.slug}" : "Snippet/#{self.id}"
	end






end
