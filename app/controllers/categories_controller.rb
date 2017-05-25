class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category_id: NIL, is_enabled: 1)
    @newCategory = Category.new
  end

  def show
    @categories = Category.where(category_id: NIL, is_enabled: 1)
    @category = Category.find(params[:id])
    @newCategory = Category.new
    @subcategory = Category.new
    @subcategories = Category.where(category_id: params[:id], is_enabled: 1).all
    @systems = System.where(category_id: params[:category_id]).all
    @system = @category.systems.new(system_params)

    @topLevel = Category.find(params[:category_id])
  end

  def new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @categories = Category.all

    if :category_id != NIL
      @category = Category.new(sub_category_params)
    else
      @category = Category.new(category_params)
    end

    @category.is_enabled = 1

    if :category_id != NIL
      @category.save
      redirect_to categories_path(@category)
    else
      @category.save
      redirect_to category_path(@category)
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

    def system_params
      params.require(:category).permit(:name, :slug, )
    end

end
