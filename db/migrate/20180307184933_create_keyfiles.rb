class CreateKeyfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :keyfiles do |t|
      t.string :winver
      t.string :winreleaseid
      t.string :winacttype
      t.string :winupdatecheck
      t.string :bitlockerstatus
      t.string :useraccount
      t.string :accountlogo
      t.string :wallpaper
      t.string :fonts
      t.string :servicewinupdate
      t.string :startuponedrive
      t.string :securityhealth
      t.string :settingfeedback
      t.string :settingnotify1
      t.string :settingnotify2
      t.string :settingwifi
      t.string :powerplan
      t.string :trayicon
      t.string :uac
      t.string :autorun
      t.string :wirelessautoconnect
      t.string :devicemanager
      t.string :eventviewapp
      t.string :eventviewsys
      t.string :chromever
      t.string :edgenewtab
      t.string :edgehomebutton
      t.string :edgehomepagebutton
      t.string :firefoxver
      t.string :flashver
      t.string :javaver
      t.string :mcafeeagentver
      t.string :mcafeevsever
      t.string :officever
      t.string :vlcver
      t.string :vlcconf
      t.string :sevenzipver
      t.string :flashsettings
      t.string :startupjava
      t.string :vlcshortcut
      t.string :pptshortcut
      t.string :timershortcut
      t.string :wmpshortcut
      t.string :mcafeelastupdate
      t.string :officepptfix
      t.string :act
      t.string :offact
      t.string :eclear
      t.string :updatescript
      t.string :description

      t.timestamps
    end
  end
end
