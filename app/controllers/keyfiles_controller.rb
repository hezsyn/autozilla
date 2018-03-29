class KeyfilesController < ApplicationController
  def index
    @keyfiles = Keyfile.all
  end

  def show
    @keyfile = Keyfile.find(params[:id])
  end

  def new
    @keyfile = Keyfile.new

  end

  def edit
    @keyfile = Keyfile.find(params[:id])
  end

  def create
    @keyfile = Keyfile.new(keyfile_params)

    if @keyfile.save
      redirect_to @keyfile
    else
      render 'new'
    end
  end

  def update
    @keyfile = Keyfile.find(params[:id])

    if @keyfile.update(keyfile_params)
      redirect_to @keyfile
    else
      render 'edit'
    end
  end

  def destroy
    @keyfile = Keyfile.find(params[:id])
    @keyfile.destroy

    redirect_to keyfiles_path
  end

  private
    def keyfile_params
        params.require(:keyfile).permit(:keyfile_type, :bios, :legalnotice, :officeinstructions, :winver, :issixtyfourbit, :winreleaseid, :winacttype, :winupdatecheck, :bitlockerstatus, :useraccount, :accountlogo, :wallpaper, :fonts, :servicewinupdate, :startuponedrive, :securityhealth, :settingfeedback, :settingnotify1, :settingnotify2, :settingwifi, :powerplan, :trayicon, :uac, :autorun, :wirelessautoconnect, :devicemanager, :eventviewapp, :eventviewsys, :chromever, :edgenewtab, :edgehomebutton, :edgehomepagebutton, :firefoxver, :flashver, :javaver, :mcafeeagentver, :mcafeevsever, :officever, :vlcver, :vlcconf, :sevenzipver, :flashsettings, :startupjava, :vlcshortcut, :pptshortcut, :timershortcut, :wmpshortcut, :mcafeelastupdate, :officepptfix, :act, :offact, :eclear, :updatescript, :description)
    end
end
