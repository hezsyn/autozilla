class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category_id: NIL, is_enabled: 1)
  end

  def show
    @categories = Category.where(category_id: NIL, is_enabled: 1)
    @category = Category.find(params[:id])
    @subcategories = Category.where(category_id: params[:id], is_enabled: 1).all
  end

  def new
    @categories = Category.new
  end

  def create
    if :category_id != NIL
      @category = Category.new(sub_category_params)
    else
      @category = Category.new(category_params)
    end

    if @category.save
      redirect_to @category
    else
      render 'new'
    end

  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

      if @category.category_id != NIL
        @category.update(sub_category_params)
      else
        @category.update(category_params)
      end

  end

  def destory
    @category = Category.find(params[:id])
    @category.update(is_enabled: 0)
  end

  private
    def sub_category_params
      params.require(:category).permit(:name, :slug, :description, :is_enabled, :category_id)
    end

    def category_params
      params.require(:category).permit(:name, :slug, :description, :is_enabled)
    end

end
