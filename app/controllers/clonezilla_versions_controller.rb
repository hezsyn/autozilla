class ClonezillaVersionsController < ApplicationController
  include  Azk::Key
  
  def index
    @czs = ClonezillaVersion.all.order('name DESC')
    @newCZ = ClonezillaVersion.new
    @locations = Location.where(enabled: 1)
    @defLocation = Location.find_by_default(1)
  end

  def new
    @cv = ClonezillaVersion.new
  end

  def create
    @czs = ClonezillaVersion.all.order('name DESC')
    @cz = ClonezillaVersion.create(czv_params)
    @cz.upload = AutozillaKeyConfig.new(purpose: "Upload")
    @cz.upload.czAZKConfig("upload")
    @cz.download = AutozillaKeyConfig.new(purpose: "Download")
    @cz.download.czAZKConfig("download")
    @cz.is_enabled = 1
    
    if @cz.save
     updateCZCFG
     flash[:notice] = "#{ClonezillaVersion.last.name} has been created."
    else
     flash[:alert] = "Failed to update"
   end
    
    redirect_to edit_clonezilla_version_path(ClonezillaVersion.last)
  end

  def edit
    @czs = ClonezillaVersion.all.order(name: :desc)
    @cz = ClonezillaVersion.find(params[:id])
    @czParam = AutozillaKeyConfig.all
    @azk = AutozillaKeyConfig.all
    @locations = Location.where(enabled: 1)
    @defLocation = Location.find_by_default(1)
    @newCZ = ClonezillaVersion.new
  end

  def update
    @cv = ClonezillaVersion.find(params[:id])
    if @cv.update(czv_params)
      updateCZCFG
      flash[:notice] = "#{@cv.name} has been updated"
    else
      flash[:alert] = @cv.errors.full_messages
    end

    redirect_to edit_clonezilla_version_path(@cv)
  end

  def populateCZFiles
    @cz = ClonezillaVersion.find(params[:id])
    
    updateCZCFG    

    flash[:notice] = "Population of files complete!"
    redirect_to edit_clonezilla_version_path(@cz)
  end

  def changeStatus
    @cz = ClonezillaVersion.find(params[:id])

      if @cz.is_enabled == 0
        @cz.update(:is_enabled => 1)
        flash[:notice] = "#{@cz.name} has been enabled"
      else
        @cz.update(:is_enabled => 0)
        flash[:notice] = "#{@cz.name} has been disabled"
      end

      updateCZCFG
      redirect_to clonezilla_versions_path
  end

  def changeDefault
    @cz = ClonezillaVersion.find(params[:id])
    @default = ClonezillaVersion.find_by_default(1)

    @default.update(default: 0)
    @cz.update(default: 1)

    redirect_to clonezilla_versions_path
  end

  private
    def czv_params
      params.require(:clonezilla_version).permit(:name, :description, :is_enabled, :location_id,:version)
    end

end
