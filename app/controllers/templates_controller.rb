class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :update, :destroy]

  def index
    @templates = Template.all
  end

  def show
  end

  def create
    @template = Template.new(template_params)

    if @template.save
      render :show, status: :created, location: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def update
    if @template.update(template_params)
      render :show, status: :ok, location: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @template.destroy
      render json: {success:['Deleted.'], status: :ok}
    else
      render json: {errors:['Not able to delete template.'], status: :unprocessable_entity}
    end
  end

  def search_by_title
    @template = Template.find_by_name(params[:name])
    if @template
      render json: @template
    else
      render json: {errors:['Not able to get the template.'], status: :unprocessable_entity}
    end
  end

  private
    def set_template
      @template = Template.find(params[:id])
    end
    def template_params
      params.permit(:template_id, :name, :description)
    end
end
