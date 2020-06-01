module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end
  def authorize
    unless current_user
      flash[:notice] = 'ログインしてください'
      redirect_to new_session_path
    end
  end
end
