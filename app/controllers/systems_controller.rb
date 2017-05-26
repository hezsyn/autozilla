class SystemsController < ApplicationController

  def show
    @parentCategory = Category.find(params[:id])
    @systems = @parentCategory.systems.all
    @newSystem = @parentCategory.systems.build
    @subcategories = Category.where(category_id: params[:id]).all
  end

  def new

    @system = System.new
  end

  def create
    @category = Category.find(params[:category_id])
    @system = @category.systems.new(system_params)
    @system.is_enabled = 1
    @system.save

    redirect_to category_path(@category)
  end

  def edit
    @system.find(params[:id])
  end

  def update
    @system.update(system_params)
  end

  def destroy

  end

  private
    def system_params
      params.require(:system).permit(:name, :description, :is_enabled, :category_id)
    end

end
