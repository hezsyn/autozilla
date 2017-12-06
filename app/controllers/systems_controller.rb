class SystemsController < ApplicationController

  def show
    @category = Category.find(params[:category_id])
    @system = System.find(params[:id])
    @systems = @category.systems.where(is_enabled: 1).order(:name)
    @images = @system.images.order(:name)
    @pools = Pool.all
    @oses = Ose.all
    @imagesStatuses = ImageStatus.order(:name)
    @clonezillas = ClonezillaVersion.order(:name)
    @image_types = ImageType.order(:name)
  end

  def new
    @system = System.new
  end

  def create
    @category = Category.find(params[:category_id])
    @system = @category.systems.new(system_params)
    @system.file_location = @system.objectLocation
    @system.slug = @system.name
    @system.makeSlug
    @system.is_enabled = 1
    @system.default_disk.downcase!
    if @system.save
      flash[:notice] = "System has been created!"
      @category.createAZKCategoryFiles
      @system.createAZKSystemFiles
    else
      flash[:alert] = @system.errors.full_messages
    end

    redirect_to category_path(@category)
  end

  def edit
    @system = System.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @system = @category.systems.find(params[:id])
    @system.removeEntry("system", @system)
    @system.slug = @system.name
    @system.makeSlug
    @system.default_disk.downcase!

    if @system.update(system_params)
      flash[:notice] = "System has been updated"
      @system.file_location = @system.objectLocation
      @system.update(system_params)
      @category.createAZKCategoryFiles
      @system.createAZKSystemFiles
    else
      flash[:alert] = "System failed to update"
    end

    redirect_to category_system_path(@category, @system)
  end

  def destroy
    @system = System.find(params[:id])
    @parentCategory = Category.find(@system.category_id)
    if @system.is_enabled == 1
      @system.update(:is_enabled => 0)
      flash[:notice] = "#{@system.name} has been archived"
      redirect_to category_path(@parentCategory)
    else
      @system.update(is_enabled: 1)
      flash[:notice] = "#{@system.name} has been enabled"
      redirect_to category_system_path(@parentCategory, @system)
    end
  end

  private
    def system_params
      params.require(:system).permit(:name, :slug, :description, :is_enabled, :category_id, :default_disk, :file_location)
    end

end
