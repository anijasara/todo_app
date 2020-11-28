class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :set_task_status]

  def index
    @tasks = Task.all
  end

  def show
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render :show, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render :show, status: :ok, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  def set_task_status
    if @task && @task.update(status: params[:status])
      render :show, status: :ok, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def get_tasks_by_status
    tasks = Task.where(status: params[:status])
    if tasks.present?
      render json: tasks
    elsif tasks.empty?
      render json: {success:["No tasks with #{params[:status]} status"], status: :ok}
    else
      render json: {errors:['Not able to get the tasks.'], status: :unprocessable_entity}
    end
  end

  def search_task_by_param
    tasks = Task.get_task_by_params(params[:param_name], params[:param_value])
    if tasks.present?
      render json: tasks
    elsif tasks.empty?
      render json: {success:["No tasks with #{params[:param_name]} as #{params[:param_value]}"], status: :ok}
    else
      render json: {errors:['Not able to get the tasks.'], status: :unprocessable_entity}
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.permit(:task_id, :name, :description, :status, :done_at, :due_at, :list_id)
    end
end
