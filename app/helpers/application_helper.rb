module ApplicationHelper
	def current_user
		if session[:session_token]
			@current_user = User.find_by_session_token(session[:session_token])
		else
			@current_user = User.new_guest
			# @current_user.session_token = session[:session_token]
		end
	end

  def require_login
    unless current_user
      redirect_to new_session_url
    end
  end
end
