class AutozillaKeyConfigsController < ApplicationController
    include Azk::Key
  def index

  end

  def new
    @cv = ClonezillVersion.find(params[:id])
  end

  def create
    @cv = ClonezillaVersion.find(params[:clonezilla_versions_id])
    @azk = AutozillaKeyConfig.find(params[:id])
  end

  def edit
  end

  def update
    @azk = AutozillaKeyConfig.find(params[:id])
    @azk.update(azk_params)

    redirect_to clonezilla_versions_path
  end

  def restoreKey
    @categories = Category.where(:is_enabled => 1).order(:name)
    @systems = System.where(:is_enabled => 1).order(:name)
    @category = Category.first

    # Deletes current AZ key
    @category.removeAZK
    # Creates directory setup for new Key
    @category.createAZKDefault
    # Migrates all Clonezillas, and creates a new entries
    @category.migrateClonezillas

    # Creating the self update files
    @category.createSelfUpdate
    # Start of creating all new key entries for key
    # Create top.menu first, this is the top categories which don't worry about the @category
    # The method calls the correct ones.
    @category.createTopLevel
    # Now to create the categories under the top level
    @categories.each do |cat|
      cat.createAZKCategoryFiles
    end
    # Now we have the system files!
    @systems.each do |sys|
      sys.createAZKSystemFiles
    end

    # That should be it.  Hopefully.
    flash[:notice] = "Reset complete"
    redirect_to autozilla_key_path
  end

  def selfUpdate
    createSelfUpdate
    flash[:notice] = "SelfUpdate has been recreated"
    redirect_to autozilla_key_path
  end

  def rebuildKey
    @category.createTopLevel
    # Now to create the categories under the top level
    @categories.each do |cat|
      cat.createAZKCategoryFiles
    end
    # Now we have the system files!
    @systems.each do |sys|
      sys.createAZKSystemFiles
    end
  end

  private
    def azk_params
      params.require(:autozilla_key_config).permit(:params_set, :flags, :location, :live_run, :live_keymap, :live_param, :live_batch, :prerun0, :postrun0, :prerun1, :postrun1, :prerun2, :postrun2, :prerun3, :postrun3, :prerun4, :postrun4, :edd, :locales)
    end

end
