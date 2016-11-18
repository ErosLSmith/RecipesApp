class StylesController < ApplicationController
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
	end
	private
		def style_params
			params.require(:style).permit(:name)
		end
end