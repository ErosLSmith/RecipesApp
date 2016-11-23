class RecipesController < ApplicationController
	before_action :set_recipe,  only: [:edit, :update ,:show]
	before_action :require_same_user , only: [:edit, :update]
	before_action :require_user, except: [:show, :index]


	def index
		@recipes = Recipe.paginate(page: params[:page], per_page: 10)
	end

	def show
		@title = @recipe.name
	end

	def new
		@title = "New Recipe"
		@submit_button_text = "Create"
		@recipe = Recipe.new
		@obj = @recipe
	end
	
	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = current_user
		@obj = @recipe
		
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
		@obj = @recipe
	end
	
	def update
		if @recipe.update(recipe_params)
			flash[:success] = "Successfully Updated"
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end

	def like
		@recipe = Recipe.find(params[:id])
		like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
		
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
			params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
		end
		def require_same_user
			if current_user != @recipe.chef
				flash[:danger] = "Only allowed to edit own recipe"
				redirect_to root_path
			end
		end
		def set_recipe
			@recipe = Recipe.find(params[:id])
		end

end