module ApplicationHelper
	include SessionHelper
	
	def current_user
		if session[:session_token]
			@current_user = User.find_by_session_token(session[:session_token])
		else
			@current_user = User.new_guest
			login_user(@current_user)
		end
	end

  def require_login
    if current_user.guest?
    	flash[:notice] = "Please login to view that page."
      redirect_to login_url
    end
  end
end
