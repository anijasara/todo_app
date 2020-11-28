class ListsController < ApplicationController

  before_action :set_list, only: [:show, :update, :destroy, :get_tasks, :remove_tasks]


  def index
    @lists = List.all
  end

  def show
  end

  def create
    @list = List.new(list_params)

    if @list.save
      render :show, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render :show, status: :ok, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
  end

  def get_tasks
    if @list.tasks
      render json: @list.tasks
    else
      render json: {errors:['Not able to list tasks.'], status: :unprocessable_entity}
    end
  end

  def search_by_name
    @list = List.find_by_name(params[:name])
    if @list
      render json: @list
    else
      render json: {errors:['Not able to get the list.'], status: :unprocessable_entity}
    end
  end

  def remove_tasks
    if List.delete_tasks(params[:task_ids])
      render json: {success:['Deleted.'], status: :ok}
    else
      render json: {errors:['Not able to delete tasks.'], status: :unprocessable_entity}
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.permit(:list_id, :name)
    end
end
