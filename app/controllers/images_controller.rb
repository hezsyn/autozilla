class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def new
    @image = Image.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @image = @system.images.new(image_params)
    @image.file_location = @image.img_file_location
    if params[:image][:clonezilla_version_id].present?
      @cz = ClonezillaVersion.find(params[:image][:clonezilla_version_id])
      @image.upload = @cz.upload
      @image.download = @cz.download
    end
    @image.disk.downcase!
    if @image.save
      flash[:notice] = "Image has been successfully created!"
      @image.createAZKSystemFiles
    else
      flash[:alert] = @image.errors
    end

    redirect_to category_system_path(@category, @system)
  end

  def edit
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @image = Image.find(params[:id])
    @netUpPath = @image.upload.location
    @images = @system.images.all
    @notes = @image.notes.all

    @locations = Location.all
    @image_types = ImageType.where(is_enabled: 1)
    @image_statuses = ImageStatus.where(is_visible: 1)
    @clonezillas = ClonezillaVersion.order(name: :desc).where(is_enabled: 1)
    @oss = Ose.where(is_enabled: 1)
    @pools = Pool.where(is_enabled: 1).order(:name)
  end

  def update
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @image = Image.find(params[:id])

    if params[:image][:clonezilla_version_id] != @image.clonezilla_version_id
      @cz = ClonezillaVersion.find(params[:image][:clonezilla_version_id])
      @image.upload = @cz.upload
      @image.download = @cz.download
    end

    if @image.update(image_params)
      flash[:notice] = "#{@image.name} has been updated"
      @image.file_location = @image.img_file_location
      @image.save
      @image.createAZKSystemFiles
    else
      flash[:alert] = @image.errors
    end

    redirect_to edit_category_system_image_path(@category, @system, @image)
  end

  private
    def image_params
      params.require(:image).permit(:name, :note, :description, :disk, :pool_id, :user_id, :ose_id, :image_status_id, :clonezilla_version_id, :system_id, :file_location, :image_type_id, :grub_upload_id, :grub_download_id, :syslinux_upload_id, :syslinux_download_id, :azkName, :current, :location_id, :document)
    end

end