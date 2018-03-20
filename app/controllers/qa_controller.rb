class QaController < ApplicationController
  def index
    # Check URL Parameter capturedate against latest Keyfile created_at date to determine which Keyfile to use.
    if params[:capturedate]
      if params[:imagetype] == 'USDD'
        if Date.strptime(params[:capturedate], '%m/%d/%Y') > Keyfile.where(keyfile_type: 'USDD').order("created_at").last.created_at
          @qas = Keyfile.where(keyfile_type: 'USDD').order("created_at").last
        else
          @qas = Keyfile.where(keyfile_type: 'USDD').order("created_at").offset(1).last
        end
      elsif params[:imagetype] == 'iDDR'
        if Date.strptime(params[:capturedate], '%m/%d/%Y') > Keyfile.where(keyfile_type: 'iDDR').order("created_at").last.created_at
          @qas = Keyfile.where(keyfile_type: 'iDDR').order("created_at").last
        else
          @qas = Keyfile.where(keyfile_type: 'iDDR').order("created_at").offset(1).last
        end
      end
    else
      redirect_to '/view'
    end
  end

  def view
    @datas = Qa.all
  end

  def show
    @data = Qa.find(params[:id])
    if @data.keyfileid
      @qas = Keyfile.find(@data.keyfileid)
    else
      @qas = Keyfile.order("created_at").last
    end
  end

  def new
    @qa = Qa.new
  end

  def create
    if params[:imagetype] == 'USDD'
      @qa = Qa.new(qa_params)
    elsif params[:imagetype] == 'iDDR'
      @qa = Qa.new(qa_params_iddr)
    end

    if @qa.save
      flash[:notice] = "Report Successfully Created"
      redirect_to @qa
    else
        flash[:notice] = @qa.errors.full_messages
        redirect_to qa_index_path
    end
  end

  private
    def qa_params
      params.permit(:keyfileid, :idsid, :hostname, :capturedate, :imagedescription, :imagetype, :imageinitials, :mac, :uuid, :bios, :winver, :winreleaseid, :winacttype, :winupdatecheck, :bitlockerstatus, :useraccount, :accountlogo, :wallpaper, :fonts, :servicewinupdate, :startuponedrive, :securityhealth, :settingfeedback, :settingnotify1, :settingnotify2, :settingwifi, :powerplan, :trayicon, :uac, :autorun, :wirelessautoconnect, :devicemanager, :eventviewapp, :eventviewsys, :chromever, :edgenewtab, :edgehomebutton, :edgehomepagebutton, :firefoxver, :flashver, :javaver, :mcafeeagentver, :mcafeevsever, :officever, :vlcver, :vlcconf, :sevenzipver, :flashsettings, :startupjava, :vlcshortcut, :pptshortcut, :timershortcut, :wmpshortcut, :mcafeelastupdate, :officepptfix, :act, :offact, :eclear, :updatescript, :description)
    end

    def qa_params_iddr
      params.permit(:keyfileid, :idsid, :hostname, :capturedate, :imagedescription, :imagetype, :imageinitials, :mac, :uuid, :bios, :legalnotice, :winver, :winreleaseid, :winacttype, :winupdatecheck, :bitlockerstatus, :useraccount, :accountlogo, :wallpaper, :fonts, :wirelessautoconnect, :devicemanager, :eventviewapp, :eventviewsys, :edgenewtab, :edgehomebutton, :edgehomepagebutton, :firefoxver, :officever, :act, :offact, :eclear, :updatescript, :description, :officeinstructions)
    end
end
