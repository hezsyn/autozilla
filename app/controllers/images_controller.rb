class ImagesController < ApplicationController

  def show

  end

  def new
    @image = Image.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @cz = ClonezillaVersion.find(params[:image][:clonezilla_version_id])
    @image = @system.images.new(image_params)
    @image.file_location = @image.objectLocation
    @image.grub_upload_id = @cz.grub_upload_id
    @image.grub_download_id = @cz.grub_download_id
    @image.syslinux_upload_id = @cz.syslinux_upload_id
    @image.syslinux_download_id = @cz.syslinux_download_id

    @image.save
    redirect_to category_system_path(@category, @system)
  end

  def edit
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @image = Image.find(params[:id])
    @images = @system.images.all
    @notes = @image.notes.all

    @image_types = ImageType.all
    @image_statuses = ImageStatus.all
    @clonezillas = ClonezillaVersion.all
    @oss = Ose.where(:is_enabled => 1)
    @pools = Pool.all
  end

  def update
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @image = Image.find(params[:id])
    @image.update(image_params)

    redirect_to edit_category_system_image_path(@category, @system, @image)
  end

  private
    def image_params
      params.require(:image).permit(:name, :note, :description, :disk, :flags, :flags_upload, :path, :loader_string, :pool_id, :user_id, :ose_id, :image_status_id, :clonezilla_version_id, :system_id, :file_location, :image_type_id, :grub_upload_id, :grub_download_id, :syslinux_upload_id, :syslinux_download_id)
    end

end