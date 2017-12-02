class AutozillaKeyConfigsController < ApplicationController

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

  private
    def azk_params
      params.require(:autozilla_key_config).permit(:params_set, :flags, :location, :live_run, :live_keymap, :live_param, :live_batch, :prerun0, :postrun0, :prerun1, :postrun1, :prerun2, :postrun2, :prerun3, :postrun3, :prerun4, :postrun4, :edd, :locales)
    end

end
