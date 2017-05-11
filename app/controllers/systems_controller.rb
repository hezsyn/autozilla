class SystemsController < ApplicationController

  def show
    @parentCategory = Category.find(params[:category_id]])
    @topCategory = Category.where(:id => @parentCategory.id)
    @systems = System.all
    @newSystem =
  end

  def new

  end

  def edit

  end

  def destroy

  end

  private
    def system_params
      params.require(:system).permit(:name, :description, :is_enabled, :category_id)
    end

end
