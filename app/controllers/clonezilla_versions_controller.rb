class ClonezillaVersionsController < ApplicationController

  def index
    @czvs = ClonezillaVersion.all.order('name DESC')
    @newCV = ClonezillaVersion.new
  end

  def show
    @cv = ClonezillaVersion.find(params[:id])
  end

  def new
    @cv = ClonezillaVersion.new
  end

  def create
    @cv = ClonezillaVersion.create(czv_params)
    @cv.upload = AutozillaKeyConfig.new(purpose: "Upload")
    @cv.upload.czAZKConfig("upload")
    @cv.download = AutozillaKeyConfig.new(purpose: "Download")
    @cv.download.czAZKConfig("download")
    @cv.is_enabled = 1
    @cv.save

    redirect_to clonezilla_versions_path
  end

  def edit
    @czs = ClonezillaVersion.all.order(name: :desc)
    @cz = ClonezillaVersion.find(params[:id])
    @czParam = AutozillaKeyConfig.all
    @azk = AutozillaKeyConfig.all
  end

  def update
    @cv = ClonezillaVersion.find(params[:id])
    @cv.update(czv_params)

    redirect_to edit_clonezilla_verion_path(@cv)
  end

  def destroy
    @cz = ClonezillaVersion.find(params[:id])
      if @cz.is_enabled == 0
        @cz.update(:is_enabled => 1)
        flash[:notice] = "#{@cz.name} has been enabled"
      else
        @cz.update(:is_enabled => 0)
        flash[:notice] = "#{@cz.name} has been disabled"
      end

    redirect_to clonezilla_versions_path
  end

  private
    def czv_params
      params.require(:clonezilla_version).permit(:name, :description, :is_enabled)
    end

end
