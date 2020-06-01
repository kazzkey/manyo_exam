class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    if @user != current_user
      redirect_to root_path
    end
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'アカウントが作成されました'
    else
      render :new
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
