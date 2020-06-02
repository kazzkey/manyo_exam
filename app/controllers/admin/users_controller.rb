class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin?
  layout "admin_layout"

  def index
    @users = User.page(params[:page]).per(5).select(:id, :name, :email, :admin).asc
    @labels = Label.page(params[:page]).per(3)
  end

  def show
    @tasks = @user.tasks
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザ情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザを削除しました'
    else
      redirect_to admin_users_path, notice: '管理者ユーザは削除できません'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
