class SystemsController < ApplicationController

  def show
    @parentCategory = Category.find(params[:id])
    @topCategory = Category.find(params[:category_id])
    @systems = @parentCategory.systems.all
    @newSystem = @parentCategory.systems.build
    @subcategories = Category.where(category_id: params[:id], is_enabled: 1).all
  end

  def new
    @system = System.new
  end

  def create
    @system.create(system_params)
    @system.save

    redirect_to category_sublevel_1_system_path
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def system_params
      params.require(:system).permit(:name, :description, :is_enabled, :category_id)
    end

end
