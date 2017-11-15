class SystemsController < ApplicationController

  def show
    @category = Category.find(params[:category_id])
    @system = System.find(params[:id])
    @systems = @category.systems.order(:name)
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
    @system.save

    @category.createAZKCategoryFiles
    @system.createAZKSystemFiles

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

    @system.update(system_params)

    @system.file_location = @system.objectLocation
    @system.update(system_params)

    @category.createAZKCategoryFiles
    @system.createAZKSystemFiles

    redirect_to category_system_path(@category, @system)
  end

  def destroy

  end

  private
    def system_params
      params.require(:system).permit(:name, :slug, :description, :is_enabled, :category_id, :default_disk, :file_location)
    end

end
