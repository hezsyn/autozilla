class SystemsController < ApplicationController

  def show
    @category = Category.find(params[:category_id])
    @system = System.find(params[:id])
    @systems = @category.systems.all
    @images = @system.images.all
    @pools = Pool.all
    @oses = Ose.all
    @imagesStatuses = ImageStatus.all
    @clonezillas = ClonezillaVersion.all
    @image_types = ImageType.order(:name).all
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
    @system.save

    @system.createAZKCategoryFiles

    redirect_to category_path(@category)
  end

  def edit
    @system = System.find(params[:id])
  end

  def update
    @category = Category.find(:category_id)
    @system = System.update(system_params)
    @system.createAZKCategoryFiles

    redirect_to category_path(@category)
  end

  def destroy

  end

  private
    def system_params
      params.require(:system).permit(:name, :slug, :description, :is_enabled, :category_id, :default_disk)
    end

end
