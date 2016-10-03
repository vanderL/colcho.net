class Room < ActiveRecord::Base
	extend FriendlyId

	has_many :reviews, dependent: :destroy
	belongs_to :user
	
	validates_presence_of :title, :location, :description
	validates_length_of :description, minium: 10, allow_blank: false
	validates_presence_of :slug

	friendly_id :title, use: [:slugged, :history]

  	def self.most_recent
    	order(created_at: :desc)
  	end

	def complete_name
		"#{title}, #{location}"
		
	end

	def self.search(query)
		if query.present?
			where(['location LIKE :query OR title LIKE :query OR description LIKE :query', query: "%#{query}%"])
		else
			all
		end
	end
end
