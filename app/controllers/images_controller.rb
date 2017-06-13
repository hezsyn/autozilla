class ImagesController < ApplicationController

  def show

  end

  def new
    @image = Image.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @system = System.find(params[:system_id])
    @image = @system.images.new(image_params)

    @image.save
    redirect_to category_system_path(@category, @system)
  end


  private
    def image_params
      params.require(:image).permit(:name, :note, :description, :disk, :flags, :flags_upload, :path, :loader_string, :pool_id, :user_id, :ose_id, :image_status_id, :clonezilla_version_id, :system_id)
    end

end