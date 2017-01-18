class Room < ApplicationRecord
	belongs_to :user
	has_many :reviews, dependent: :destroy

	validates_presence_of :title
	validates_presence_of :location

	def complete_name
		"#{title}, #{location}"
	end
end
