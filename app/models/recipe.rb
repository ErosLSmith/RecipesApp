class Recipe < ActiveRecord::Base
	belongs_to :chef
	has_many :likes
	validates :name, presence: true, length: { minimum: 5, maximum: 100 }
	validates :chef_id, presence: true
	validates :summary, presence: true, length: { minimum: 5, maximum: 1000 }
	validates :description, presence: true, length: { minimum: 5, maximum: 10000 }
	mount_uploader :picture, PictureUploader
	validate :picture_size
	default_scope -> { order(updated_at: :desc) }

	def num_likes
		self.likes.where(like: true).size
	end

	def num_dislikes
		self.likes.where(like: false).size
	end

	private
		def picture_size
			if picture.size > 5.megabytes
			errors.add(:picture, "should be less than 5MB")
			end
		end
end
