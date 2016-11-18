class IngredientsController < ApplicationController
	def new
		@title = "New Ingredient"
		@submit_button_text = "Create"
		@ingredient = Ingredient.new
		@obj = @ingredient
	end
	def create
		@ingredient = Ingredient.new(ingredient_params)
		@obj = @ingredient
		
		if @ingredient.save
			flash[:success] = "Successfully Created"
			redirect_to recipes_path
		else
			render :new
		end
	end
	def show
	end
	private
		def ingredient_params
			params.require(:ingredient).permit(:name)
		end
end