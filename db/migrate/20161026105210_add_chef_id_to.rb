class AddChefIdTo < ActiveRecord::Migration
  def change
  	add_column :recipes, :chef_id, :interger
  end
end
