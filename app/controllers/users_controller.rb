class UsersController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			flash[:notice] = "Account created. Please login."
			redirect_to new_session_url
		else
			flash[:notice] = "Unable to create account. Try again."
			render :new
		end
	end

	def edit
		@user = current_user
		render :edit
	end

	def update
	end

	def show
		@user = User.find(params[:id])
		@bills = @user.bills
		print "### Bills"
		print @bills
		render :show
	end
end