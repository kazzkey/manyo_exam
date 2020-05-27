class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.page(params[:page]).per(5).sortby_expired_at
    elsif params[:sort_priority]
      @tasks = Task.page(params[:page]).per(5).sortby_priority
    elsif params[:search]
      if params[:name].present? && params[:status].present?
        @tasks = Task.page(params[:page]).per(5).name_like(params[:name]).status(params[:status])
      elsif params[:name].present?
        @tasks = Task.page(params[:page]).per(5).name_like(params[:name])
      elsif params[:status].present?
        @tasks = Task.page(params[:page]).per(5).status(params[:status])
      end
    else
      @tasks = Task.page(params[:page]).per(5).desc
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
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :content, :expired_at, :status, :priority)
  end
end
