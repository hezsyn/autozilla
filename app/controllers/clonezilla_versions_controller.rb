class ClonezillaVersionsController < ApplicationController
  include Azk::Key

  def index
    @czvs = ClonezillaVersion.all.order('name DESC')
    @newCV = ClonezillaVersion.new
    @locations = Location.all
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
    if @cv.save
     createCZFile
     flash[:notice] = "#{@cv.name} has been created."
    else
     flash[:alert] = @cv.errors.full_messages
   end

    redirect_to edit_clonezilla_version_path(@cv)
  end

  def edit
    @czs = ClonezillaVersion.all.order(name: :desc)
    @cz = ClonezillaVersion.find(params[:id])
    @czParam = AutozillaKeyConfig.all
    @azk = AutozillaKeyConfig.all
    @locations = Location.all
    @newCV = ClonezillaVersion.new

    @rootDir = SupportStuff.find_by(name: "rootKeyDir").value + '/'
    @czSource = @rootDir +  SupportStuff.find_by(name: "czSource").value + '/'
    @czProduction = @rootDir +  SupportStuff.find_by(name: "czProduction").value + '/'
    @incomingCZ = @rootDir +  SupportStuff.find_by(name: "incomingCZ").value + '/'
  end

  def update
    @cv = ClonezillaVersion.find(params[:id])
    if @cv.update(czv_params)
      createCZFile
      flash[:notice] = "#{@cv.name} has been updated"
    else
      flash[:alert] = @cv.errors.full_messages
    end

    redirect_to edit_clonezilla_version_path(@cv)
  end

  def populateCZFiles
    @cz = ClonezillaVersion.find(params[:id])

    @cz.newCZFiles

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

      createCZFile
      redirect_to clonezilla_versions_path
  end

  private
    def czv_params
      params.require(:clonezilla_version).permit(:name, :description, :is_enabled, :location_id,:version)
    end

end
