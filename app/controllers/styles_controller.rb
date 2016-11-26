class StylesController < ApplicationController
	before_action :set_style, only: [:show, :destroy]
	before_action :require_user, except: [:show, :index]
	before_action :require_admin , only: [:destroy]
	
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

	def destroy
		if @style.destroy
			flash[:success] = "Successfully Deleted"
			redirect_to styles_path
		end
	end

	private
		def style_params
			params.require(:style).permit(:name)
		end
		def set_style
			@style = Style.find(params[:id])
		end
end