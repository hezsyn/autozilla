class SystemsController < ApplicationController

  def show
    @category = Category.find(params[:category_id])
    @system = System.find(params[:id])
    @systems = @category.systems.where(is_enabled: 1).order(:name)
    @images = @system.images.order(:name)

    # Variables for new image, they only pull enabled entries.  Location is only one with no turn off.
    @image_types = ImageType.where(is_enabled: 1)
    @image_statuses = ImageStatus.where(is_visible: 1)
    @clonezillas = ClonezillaVersion.order(name: :desc).where(is_enabled: 1)
    @oss = Ose.where(:is_enabled => 1)
    @pools = Pool.where(is_enabled: 1)
    @locations = Location.order(:name)
  end

  def new
    @system = System.new
  end

  def create
    @category = Category.find(params[:category_id])
    @system = @category.systems.new(system_params)
    @system.file_location = @system.objectLocation
    @system.slug = @system.name
    @system.is_enabled = 1
    @system.makeSlug("system")
    @system.default_disk.downcase!
    if @system.save
      flash[:notice] = "System has been created!"
      @system.save
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
    if @system.name != params[:system][:name] then
      @system.removeEntry("system", @system)
      @system.slug = params[:system][:name]
      @system.makeSlug("system")
    end
    @system.default_disk.downcase!

    if @system.update(system_params)
      flash[:notice] = "System has been updated"
      @system.file_location = @system.objectLocation
      @system.save
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
      @parentCategory.createAZKCategoryFiles
      redirect_to category_path(@parentCategory)
    else
      @system.update(is_enabled: 1)
      flash[:notice] = "#{@system.name} has been enabled"
      @parentCategory.createAZKCategoryFiles
      redirect_to category_system_path(@parentCategory, @system)
    end
  end

  private
    def system_params
      params.require(:system).permit(:name, :slug, :description, :is_enabled, :category_id, :default_disk, :file_location)
    end

end
