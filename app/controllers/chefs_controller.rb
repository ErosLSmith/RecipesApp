class ChefsController < ApplicationController
	before_action :set_chef,  only: [:edit, :update ,:show ,:destroy]
	before_action :require_user, except: [:show, :index, :new, :create]
	before_action :require_same_user , only: [:edit, :update]
	before_action :require_not_user , only: [:new, :create]
	before_action :require_admin , only: [:destroy]
	
	def show
		@title = @chef.chefname
		@recipes = @chef.recipes.paginate(page: params[:page], per_page: 10)
	end
	def index
		@chefs = Chef.paginate(page: params[:page], per_page: 10)
	end
	def new
		@chef = Chef.new
		@obj = @chef
	end
	def create
		@chef = Chef.new(chef_params)
		@obj = @chef
		
		if @chef.save
			flash[:success] = "Successfully Created"
			session[:chef_id] = @chef.id
			redirect_to recipes_path
		else
			render :new
		end
	end
	def edit
		@title = "Edit Chef"
		@submit_button_text = "Edit"
		@obj = @chef

	end
	def update
		@obj = @chef
		if @chef.update(chef_params)
			flash[:success] = "Successfully Updated"
			redirect_to chef_path(@chef)
		else
			render :edit
		end
	end

	def destroy
		if @chef.destroy
			flash[:success] = "Successfully Deleted"
			redirect_to chefs_path
		end
	end

	private
		def chef_params
			params.require(:chef).permit(:chefname, :email, :password, :picture)
		end
		def require_same_user
			if current_user != @chef 
				flash[:danger] = "Only allowed to edit own profile"
				redirect_to root_path
			end
		end
		def set_chef
			if Chef.exists?(params[:id])
				@chef = Chef.find(params[:id])
			else
				redirect_to :back
			end
		end
end
