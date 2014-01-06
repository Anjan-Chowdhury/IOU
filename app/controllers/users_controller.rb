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
		@user = User.find_by_name(params[:id])
		@bills = @user.bills
		@payments = Debt.where(:creditor_id => @user.id, :is_a_payment => true)
		print "### Bills"
		print @bills
		render :show
	end
end