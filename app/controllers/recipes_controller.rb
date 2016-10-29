class RecipesController < ApplicationController
	def index
		@recipes = Recipe.paginate(page: params[:page], per_page: 2)
	end

	def show
		@recipe = Recipe.find(params[:id])
		@title = @recipe.name
	end

	def new
		@title = "New Recipe"
		@submit_button_text = "Create"
		@recipe = Recipe.new
	end
	
	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = Chef.find(1)
		
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

	def like
		@recipe = Recipe.find(params[:id])
		like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
		
		if like.valid?
			flash[:success] = "Thanks for your feedback!"
			redirect_to :back
		else
			flash[:danger] = "Not able to like/dislike again"
			redirect_to :back
		end
	end
	
	private
		def recipe_params
			params.require(:recipe).permit(:name, :summary, :description, :picture)
		end
end