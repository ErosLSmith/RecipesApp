class Chef < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	has_many :recipes, dependent: :destroy
	has_many :likes, dependent: :destroy
	validates :chefname, presence: true, length: { minimum: 1, maximum: 100 }
	validates :email, presence: true, length: { minimum: 5, maximum: 100 } ,
	 format: { with:  VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
	has_secure_password
	mount_uploader :picture, PictureUploader
	validate :picture_size

	
	private
		def picture_size
			if picture.size > 5.megabytes
			errors.add(:picture, "should be less than 5MB")
			end
		end
end
