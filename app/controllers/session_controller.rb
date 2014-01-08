class SessionController < ApplicationController
	include ApplicationHelper, SessionHelper

	def new
		render :new
	end

	def create
		@user = User.find_by_email(params[:user][:email])

		if @user && @user.verify_password(params[:user][:password])
			login_user(@user)
			flash[:notice] = "Successfully logged in."
			redirect_to user_url(@user)
		else
			flash[:notice] = "Problem logging in. Please try again."
			render :new
		end
	end

	def destroy
		logout_user
		flash[:notice] = "Successful logout."
		redirect_to new_session_url
	end
end
