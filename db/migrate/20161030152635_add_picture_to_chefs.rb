class AddPictureToChefs < ActiveRecord::Migration
  def change
  	add_column :chefs, :picture, :string
    add_column :chefs, :string, :string
  end
end
