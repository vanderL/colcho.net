class Room < ActiveRecord::Base

	belongs_to :user
	validates_presence_of :title, :location, :description
	validates_length_of :description, minium: 10, allow_blank: false



	def complete_name
		"#{title}, #{location}"
		
	end
end
