class RecipesController < ApplicationController
	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
		@title = @recipe.name
	end

	def new
		# @chef = Chef.find(params[:chef_id])
		@title = "New Recipe"
		@submit_button_text = "Create"
		@recipe = Recipe.new
	end
	
	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = Chef.find(2)
		
		if @recipe.save
			flash[:success] = "Successfully Created"
			redirect_to recipes_path
		else
			render :new
		end
	end

	def edit
		@title = "Edit Recipe"
		@submit_button_text = "Edit"
		@recipe = Recipe.find(params[:id])
	end
	
	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "Successfully Updated"
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end
	
	private
		def recipe_params
			params.require(:recipe).permit(:name, :summary, :description)
		end
end