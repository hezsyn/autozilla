class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category_id: nil, is_enabled: 1).order(:name)
    @newCategory = Category.new
    @category = Category.first
  end

  def show
    @categories = Category.order(:name).where(category_id: nil, is_enabled: 1)
    @category = Category.find(params[:id])
    @categories = Category.where(category_id: nil, is_enabled: 1).order(:name)
    @newCategory = Category.new
    @subcategory = Category.new
    @subcategories = @category.categories.where(is_enabled: 1).order(:name)
    @systems = @category.systems.order(:name).where(is_enabled: 1)
    @system = @category.systems.build
  end

  def new
    if Category.find_by(name: params[@category.name])

    else
      @categories = Category.all
      @category = Category.new
    end
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
    @category.makeSlug("category")
    @category.is_enabled = 1
    @parentCategory = Category.find(@category.category_id) if @category.category_id != nil

    if @category.save
      flash[:notice] = "Category has been created."
      @category.createAZKCategoryFiles
      @parentCategory.createAZKCategoryFiles
    else
      flash[:alert] = @category.errors
    end

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
    if @category.name != params[:category][:name] then
      @category.removeEntry("category", @category)
      @category.slug = params[:category][:name]
      @category.makeSlug("category")
    end
    @category.file_location = @category.objectLocation

    if @category.update(category_params)
      flash[:notice] = "Category has been updated!"

      if @category.category_id != nil
        @category.createAZKCategoryFiles
        @parentCategory.createAZKCategoryFiles
      else
        @category.createAZKCategoryFiles
      end
    else
      flash[:alert] = "Category hasn't been updated."
    end

    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:id])
    @parentCategory = Category.find(@category.category_id)

    if @category.is_enabled == "1"
      @category.update(:is_enabled => "0")
      flash[:notice] = "#{@category.name} has been archived."
      @parentCategory.createAZKCategoryFiles
      redirect_to category_path(@parentCategory)
    else
      @category.update(:is_enabled => "1")
      flash[:notice] = "#{@category.name} has been enabled."
      @parentCategory.createAZKCategoryFiles
      redirect_to category_path(@category)
    end
  end

  private
    def sub_category_params
      params.require(:category).permit(:name, :slug, :description, :is_enabled, :category_id, :file_location, :search)
    end

    def category_params
      params.require(:category).permit(:name, :slug, :description, :is_enabled, :file_location, :search)
    end

end
