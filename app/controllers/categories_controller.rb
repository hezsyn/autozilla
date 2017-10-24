class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category_id: nil, is_enabled: 1).order(:name)
    @newCategory = Category.new
    @category = Category.first
    @category.createTopLevel
  end

  def show
    @categories = Category.where(category_id: nil, is_enabled: 1).order(:name)
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
    if :category_id.nil?
      @category = Category.new(category_params)
    else
      @category = Category.new(sub_category_params)
    end

    @category.file_location = @category.objectLocation
    @category.slug = @category.name
    @category.makeSlug
    @category.is_enabled = 1

    @category.save

    @parentCategory = Category.find(@category.category_id) if @category.category_id != nil
    @category.createAZKCategoryFiles
    @parentCategory.createAZKCategoryFiles

     if @category.category_id.nil?
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
    @parentCategory = Category.find(@category.category_id) if @category.category_id != nil
    @category.removeEntry("category", @category) if @category.category_id != nil
    @category.slug = @category.name
    @category.makeSlug
    @category.file_location = @category.objectLocation

    @category.update(category_params)

    if @category.category_id != nil
      @category.createAZKCategoryFiles
      @parentCategory.createAZKCategoryFiles
    else
      @category.createAZKCategoryFiles
    end

    redirect_to @category
  end

  def destory
    @category = Category.find(params[:id])
    @category.update(is_enabled: 0)
  end

  private
    def sub_category_params
      params.require(:category).permit(:name, :slug, :description, :is_enabled, :category_id, :file_location)
    end

    def category_params
      params.require(:category).permit(:name, :slug, :description, :is_enabled, :file_location)
    end

end
