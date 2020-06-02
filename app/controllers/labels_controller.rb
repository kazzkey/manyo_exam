class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]
  before_action :admin?
  layout "admin_layout"


  def new
    @label = Label.new
  end

  def edit
  end

  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to admin_users_path, notice: 'ラベルが作成されました'
    else
      render :new
    end
  end

  def update
    if @label.update(label_params)
      redirect_to admin_users_path, notice: 'ラベルが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to admin_users_path, notice: 'ラベルが削除されました'
  end

  private
  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
