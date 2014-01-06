module SessionHelper
	def logged_in?
		!!current_user
	end

	def login_user(user)
		token = SecureRandom.base64(16)
		user.session_token = token
		session[:session_token] = token
		user.save
	end

	def logout_user
		if current_user
			current_user[:session_token] = nil
			current_user.save
		end

		if session[:session_token]
			session[:session_token] = nil
		end
	end
end
