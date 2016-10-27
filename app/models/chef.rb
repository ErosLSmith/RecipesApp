class Chef < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	has_many :recipes
	validates :chefname, presence: true, length: { minimum: 1, maximum: 100 }
	validates :email, presence: true, length: { minimum: 5, maximum: 100 } ,
	 format: { with:  VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
end
