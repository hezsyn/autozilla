class Qa < ApplicationRecord

  validates :keyfileid, presence: true
  validates :idsid, presence: true
  validates :workorder, presence: true
  validates :hostname, presence: true
  validates :capturedate, presence: true
  validates :imagedescription, presence: true
  validates :imagetype, presence: true
  validates :imageinitials, presence: true
  validates :mac, presence: true
  validates :uuid, presence: true
  validates :bios, presence: true
  validates :winver, presence: true
  validates :issixtyfourbit, presence: true
  validates :winreleaseid, presence: true
  validates :winacttype, presence: true
  validates :winupdatecheck, presence: true
  validates :bitlockerstatus, presence: true
  validates :useraccount, presence: true
  validates :accountlogo, presence: true
  validates :wallpaper, presence: true
  validates :fonts, presence: true
  validates :servicewinupdate, presence: true
  validates :wirelessautoconnect, presence: true
  validates :devicemanager, presence: true
  validates :eventviewapp, presence: true
  validates :eventviewsys, presence: true
  validates :edgenewtab, presence: true
  validates :edgehomebutton, presence: true
  validates :edgehomepagebutton, presence: true
  validates :firefoxver, presence: true
  validates :officever, presence: true
  validates :act, presence: true
  validates :offact, presence: true
  validates :eclear, presence: true
  validates :updatescript, presence: true
  validates :description, presence: true

  if :imagetype == 'iDDR'
    validates :legalnotice, presence: true
    validates :officeinstructions, presence: true
  end

  if :imagetype == 'USDD'
    validates :startuponedrive, presence: true
    validates :securityhealth, presence: true
    validates :settingfeedback, presence: true
    validates :settingnotify1, presence: true
    validates :settingnotify2, presence: true
    validates :settingwifi, presence: true
    validates :powerplan, presence: true
    validates :trayicon, presence: true
    validates :uac, presence: true
    validates :autorun, presence: true
    validates :chromever, presence: true
    validates :flashver, presence: true
    validates :javaver, presence: true
    validates :mcafeeagentver, presence: true
    validates :mcafeevsever, presence: true
    validates :vlcver, presence: true
    validates :vlcconf, presence: true
    validates :sevenzipver, presence: true
    validates :flashsettings, presence: true
    validates :startupjava, presence: true
    validates :vlcshortcut, presence: true
    validates :pptshortcut, presence: true
    validates :timershortcut, presence: true
    validates :wmpshortcut, presence: true
    validates :mcafeelastupdate, presence: true
    validates :officepptfix, presence: true
  end

end
