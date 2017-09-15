class AutozillaKeyConfigsController < ApplicationController

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
    redirect_to
  end

  private
    def azk_params
      params.require(:autozilla_key_config).permit(:btldr, :purpose, :kernal, :boot, :user_name, :union, :parameters_set1, :edd, :parameters_set2, :keyboardLayout, :ocs_prerun0, :ocs_prerun1, :ocs_prerun2, :ocs_prerun3, :ocs_prerun4, :ocs_live_run, :ocs_live_keymap, :ocs_live_batch, :locales, :vga, :ifname, :parameters_set3, :fetch, :toram, :live_media_path)
    end

end
