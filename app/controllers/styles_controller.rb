class StylesController < ApplicationController
	before_action :require_user, except: [:show, :index]
	def new
		@title = "New Style"
		@submit_button_text = "Create"
		@style = Style.new
		@obj = @style
	end
	def create
		@style = Style.new(style_params)
		@obj = @style
		
		if @style.save
			flash[:success] = "Successfully Created"
			redirect_to recipes_path
		else
			render :new
		end
	end
	def show
		@style = Style.find(params[:id])
		@recipes = @style.recipes.paginate(page: params[:page], per_page: 10)
	end
	def index
		@styles = Style.paginate(page: params[:page], per_page: 10)
	end
	private
		def style_params
			params.require(:style).permit(:name)
		end
end