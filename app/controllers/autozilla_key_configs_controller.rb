class AutozillaKeyConfigsController < ApplicationController
  include Azk::Key

  def new
    @cv = ClonezillVersion.find(params[:id])
  end

  def create
    @cv = ClonezillaVersion.find(params[:clonezilla_versions_id])
    @azk = AutozillaKeyConfig.find(params[:id])
  end

  def edit
    @cz = ClonezillaVersion.find(params[:id])
  end

  def update
    @cz = ClonezillaVersion.find(params[:clonezilla])
    @azk = AutozillaKeyConfig.find(params[:id])
    @azk.update(azk_params)

    flash[:notice] = "#{@cz.name} has been updated"
    redirect_to edit_clonezilla_version_path(@cz)
  end

    def rebuildKey
      # Removing old key
      destroyStructure
      # Creating the structure
      createStructure
      # Copy the files over to the new structure
      copyAllUncreatable
      # Copy CZ Files
      copyCZFiles
      # Generating the grub.cfg / gfx files / cz file / ads file
      genGrubStructure
      #Create top level entries
      createTopMenu
      #Creation of the Category files
      createCategoryFiles
      #Creation of system files
      createSystemFiles
      
      flash[:notice] = "Complete, key has been rebuilt"
      render :index
    end

  private
    def azk_params
      params.require(:autozilla_key_config).permit(:params_set, :flags, :location, :live_run, :live_keymap, :live_param, :live_batch, :prerun0, :postrun0, :prerun1, :postrun1, :prerun2, :postrun2, :prerun3, :postrun3, :prerun4, :postrun4, :edd, :locales)
    end

end
