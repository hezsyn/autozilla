class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @subcategories = Category.where(:category_id => params[:id]).all
  end

  def new

  end

  def edit

  end

  def update

  end

  private
    def sub_category_params
      params.require(:category).permit(:name)
    end

end
