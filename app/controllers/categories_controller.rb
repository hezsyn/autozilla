class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category_id: NIL, is_enabled: 1)
    @newCategory = Category.new
  end

  def show
    @categories = Category.where(category_id: NIL, is_enabled: 1)
    @category = Category.find(params[:id])
    if @category.category_id?
      @parentCategory = Category.find(@category.category_id)
    end
    @newCategory = Category.new
    @subcategory = Category.new
    @subcategories = Category.where(category_id: params[:id], is_enabled: 1).all
    @systems = @category.systems.all
    @system = @category.systems.build
  end

  def new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @categories = Category.all

    if :category_id == NIL
      @category = Category.new(category_params)
    else
      @category = Category.new(sub_category_params)
    end

    @category.is_enabled = 1

    @category.save
     if @category.category_id == NIL
       redirect_to category_path(@category)
     else
       redirect_to category_path(@category.category_id)
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
