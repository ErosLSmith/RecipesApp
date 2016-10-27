class Recipe < ActiveRecord::Base
	belongs_to :chef
	validates :name, presence: true, length: { minimum: 5, maximum: 100 }
	validates :chef_id, presence: true
	validates :summary, presence: true, length: { minimum: 5, maximum: 100 }
	validates :description, presence: true, length: { minimum: 5, maximum: 100 }
end
