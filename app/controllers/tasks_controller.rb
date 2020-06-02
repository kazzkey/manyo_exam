class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.page(params[:page]).per(5).sortby_expired_at
    elsif params[:sort_priority]
      @tasks = current_user.tasks.page(params[:page]).per(5).sortby_priority
    elsif params[:search]
      if params[:name].present? && params[:status].present?
        @tasks = current_user.tasks.page(params[:page]).per(5).name_like(params[:name]).status(params[:status])
      elsif params[:name].present?
        @tasks = current_user.tasks.page(params[:page]).per(5).name_like(params[:name])
      elsif params[:status].present?
        @tasks = current_user.tasks.page(params[:page]).per(5).status(params[:status])
      elsif params[:label_id].present?
        @tasks = current_user.tasks.page(params[:page]).per(5).label(params[:label_id])
      else
        @tasks = current_user.tasks.page(params[:page]).per(5).desc
      end
    else
      @tasks = current_user.tasks.page(params[:page]).per(5).desc
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'タスクが作成されました'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'タスクが削除されました'
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :content, :expired_at, :status, :priority, { label_ids: [] })
  end
end
