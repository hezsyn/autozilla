# Setting some defaults
SupportStuff.create(name: 'rootKeyDir', value: '/mnt/c/Users/hezsyn/Desktop/Staging/AZK/', description: 'Default location of everything')
SupportStuff.create(name: 'sourceKey', value: 'keySource', description: 'Source directory for setting up key')
SupportStuff.create(name: 'productionKey', value: 'production', description: 'Where the key for production is stored')
# Configu for both configs for autozilla Key
SupportStuff.create(name: 'azkLocales', value: 'en_US.UTF-8')
SupportStuff.create(name: 'azkLocation', value: '//amr.corp.intel.com/idd/Infrastructure/CloneZilla/NAMO.OR.Loan/Images/automation')
SupportStuff.create(name: 'czSource', value: 'czSource')
SupportStuff.create(name: 'czProduction', value: 'production/live/CloneZilla')


# Upload config preconfigs for clonezilla
SupportStuff.create(name: 'dupParamsSet', value: 'components config noswap nolocales nodmraid nomodeset nointremap nosplash noprompt')
SupportStuff.create(name: 'dupEdd', value: 'on')
SupportStuff.create(name: 'dupPrerun0', value: 'dhclient -v eth0')
SupportStuff.create(name: 'dupPrerun1', value: 'sleep 2')
SupportStuff.create(name: 'dupPrerun2', value: 'sudo mount -t cifs #{netPath} /mnt -o user=sys_iddclonezilla,credentials=/root/.cifs.sys_iddclonezilla,sec=ntlm')
SupportStuff.create(name: 'dupPrerun3', value: 'sudo mkdir -p /mnt#{filePath}')
SupportStuff.create(name: 'dupPrerun4', value: 'sudo mount --bind /mnt#{filePath} /home/partimag/')
SupportStuff.create(name: 'dupLiveRun', value: 'ocs-sr #{surCom.flags} -scs savedisk ask_user #{self.disk}')
SupportStuff.create(name: 'dupLiveKeyMap', value: 'NONE')
SupportStuff.create(name: 'dupLiveParam', value: '')
SupportStuff.create(name: 'dupLiveBatch', value: 'no')
SupportStuff.create(name: 'dupPostrun0', value: '')
SupportStuff.create(name: 'dupPostrun1', value: '')
SupportStuff.create(name: 'dupPostrun2', value: '')
SupportStuff.create(name: 'dupPostrun3', value: '')
SupportStuff.create(name: 'dupPostrun4', value: '')
SupportStuff.create(name: 'dupFlags', value: '-q2 -j2 -z1p -sc -p choose')

# Download config preconfigs for clonezilla
SupportStuff.create(name: 'ddlParamsSet', value: 'components config noswap nolocales nodmraid nomodeset nointremap nosplash noprompt')
SupportStuff.create(name: 'ddlEdd', value: 'on')
SupportStuff.create(name: 'ddlPrerun0', value: 'dhclient -v eth0')
SupportStuff.create(name: 'ddlPrerun1', value: 'sleep 2')
SupportStuff.create(name: 'ddlPrerun2', value: 'sudo mount -t cifs #{netPath}#{filePath} /mnt -o user=sys_iddclonezilla,credentials=/root/.cifs.sys_iddclonezilla,sec=ntlm')
SupportStuff.create(name: 'ddlPrerun3', value: '')
SupportStuff.create(name: 'ddlPrerun4', value: '')
SupportStuff.create(name: 'ddlLiveRun', value: 'ocs-sr #{surCom.flags} -scr restoredisk #{self.name} #{self.disk}')
SupportStuff.create(name: 'ddlLiveKeyMap', value: 'NONE')
SupportStuff.create(name: 'ddlLiveParam', value: '')
SupportStuff.create(name: 'ddlLiveBatch', value: 'no')
SupportStuff.create(name: 'ddlPostrun0', value: '')
SupportStuff.create(name: 'ddlPostrun1', value: '')
SupportStuff.create(name: 'ddlPostrun2', value: '')
SupportStuff.create(name: 'ddlPostrun3', value: '')
SupportStuff.create(name: 'ddlPostrun4', value: '')
SupportStuff.create(name: 'ddlFlags', value: '-e2 -j2 -p choose')


# Default Categories!
Category.create(is_enabled: 1, name: '2 in 1', slug: '2_in_1')
Category.create(is_enabled: 1, name: 'All in One', slug: 'all_in_one')
Category.create(is_enabled: 1, name: 'Classmate PC', slug: 'classmate_pc')
Category.create(is_enabled: 1, name: 'Desktop', slug: 'desktop')
Category.create(is_enabled: 1, name: 'Events', slug: 'events')
Category.create(is_enabled: 1, name: 'Internet of Things', slug: 'internet_of_things_1')
Category.create(is_enabled: 1, name: 'Kits', slug: 'kits')
Category.create(is_enabled: 1, name: 'Multicast', slug: 'multicast')
Category.create(is_enabled: 1, name: 'Notebook', slug: 'notebook')
Category.create(is_enabled: 1, name: 'NUC', slug: 'nuc')
Category.create(is_enabled: 1, name: 'Server', slug: 'server')
Category.create(is_enabled: 1, name: 'Services', slug:  'services')
Category.create(is_enabled: 1, name: 'Solutions_and_Demos', slug: 'solutions_and_demos')
Category.create(is_enabled: 1, name: 'Special Approval Pool', slug: 'special_approval_pool')
Category.create(is_enabled: 1, name: 'Tablet', slug: 'tablet')
Category.create(is_enabled: 1, name: 'TME Work Space', slug: 'tme_work_space')
Category.create(is_enabled: 1, name: 'Ultrabook', slug: 'ultrabook')
# Creates File Locations for top initial entries

Pool.create(is_enabled: 1, name: 'USDD' )
Pool.create(is_enabled: 1, name: 'APAC' )
Pool.create(is_enabled: 1, name: 'SAP' )
Pool.create(is_enabled: 1, name: 'Intel_Education' )
Pool.create(is_enabled: 1, name: 'ASEP' )
Pool.create(is_enabled: 1, name: 'PCSD' )
Pool.create(is_enabled: 1, name: 'ABCD' )
Pool.create(is_enabled: 1, name: 'DCG_VMW_GTM' )
Pool.create(is_enabled: 1, name: 'ARPS' )
Pool.create(is_enabled: 1, name: 'ETSP' )
Pool.create(is_enabled: 1, name: 'VCA' )
Pool.create(is_enabled: 1, name: 'MIP' )
Pool.create(is_enabled: 1, name: 'IEM' )
Pool.create(is_enabled: 1, name: 'RSD' )
Pool.create(is_enabled: 1, name: 'STLP' )
Pool.create(is_enabled: 1, name: 'EXTERNAL' )
Pool.create(is_enabled: 1, name: 'IOTG' )
Pool.create(is_enabled: 1, name: 'PSMSP' )

Ose.create(is_enabled: 1, name: 'Linux | Wind River' )
Ose.create(is_enabled: 1, name: 'Linux | Ubuntu' )
Ose.create(is_enabled: 1, name: 'Linux | CentOS' )
Ose.create(is_enabled: 1, name: 'Win 7 Ent | 32-Bit | KMS ' )
Ose.create(is_enabled: 1, name: 'Win 7 Pro | 64-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 7 Pro | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 7 Ent | 64-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 8.1 | 32-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 8.1 | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 8.1 w/ Bing | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 8.1 w/ Bing | 32-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Pro | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Pro | 32-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Pro | 64-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Pro | 32-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Ent | 32-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Ent | 64-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Ent | 64-Bit | MAK' )
Ose.create(is_enabled: 1, name: 'Win 8.1 Ent | 32-Bit | MAK' )
Ose.create(is_enabled: 1, name: 'Win 2012R2 Data Update | KMS' )
Ose.create(is_enabled: 1, name: 'Win 2012R2 Data | KMS' )
Ose.create(is_enabled: 1, name: 'Win 2012R2 Std | KMS' )
Ose.create(is_enabled: 1, name: 'Win 10 Home | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 10 Home | 32-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 10 Home | 64-Bit | Upgrade (OEM)' )
Ose.create(is_enabled: 1, name: 'Win 10 Home | 32-Bit | Upgrade (OEM)' )
Ose.create(is_enabled: 1, name: 'Win 10 Pro | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 10 Pro | 32-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Win 10 Pro | 64-Bit | Upgrade (OEM)' )
Ose.create(is_enabled: 1, name: 'Win 10 Pro | 32-Bit | Upgrade (OEM)' )
Ose.create(is_enabled: 1, name: 'Win 10 Pro | 64-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 10 Pro | 32-Bit | KMS ' )
Ose.create(is_enabled: 1, name: 'Win 10 Ent | 64-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 10 Ent | 32-Bit | KMS' )
Ose.create(is_enabled: 1, name: 'Win 10 Ent LTSB | 64-Bit | OEM' )
Ose.create(is_enabled: 1, name: 'Other | Customer OS' )

ImageStatus.create(is_visible: 1, name: 'Production' )
ImageStatus.create(is_visible: 1, name: 'Obsolete' )
ImageStatus.create(is_visible: 1, name: 'Gold Image' )
ImageStatus.create(is_visible: 1, name: 'Development' )
ImageStatus.create(is_visible: 1, name: 'Test Image' )


7.times do
  ['Upload', 'Download'].each do |direction|
    if direction == 'Upload'
      AutozillaKeyConfig.create(purpose: direction,
                                params_set: SupportStuff.find_by(name: 'dupParamsSet').value,
                                edd: SupportStuff.find_by(name: 'dupEdd').value,
                                prerun0: SupportStuff.find_by(name: 'dupPrerun0').value,
                                prerun1: SupportStuff.find_by(name: 'dupPrerun1').value,
                                prerun2: SupportStuff.find_by(name: 'dupPrerun2').value,
                                prerun3: SupportStuff.find_by(name: 'dupPrerun3').value,
                                prerun4: SupportStuff.find_by(name: 'dupPrerun4').value,
                                live_run: SupportStuff.find_by(name: 'dupLiveRun').value,
                                live_keymap: SupportStuff.find_by(name: 'dupLiveKeyMap').value,
                                live_batch: SupportStuff.find_by(name: 'dupLiveBatch').value,
                                locales: SupportStuff.find_by(name: 'azkLocales').value,
                                flags: SupportStuff.find_by(name: 'dupFlags').value,
                                location: SupportStuff.find_by(name: 'azkLocation').value
                                )
    else
      AutozillaKeyConfig.create(purpose: direction,
                                params_set: SupportStuff.find_by(name: 'ddlParamsSet').value,
                                edd: SupportStuff.find_by(name: 'ddlEdd').value,
                                prerun0: SupportStuff.find_by(name: 'ddlPrerun0').value,
                                prerun1: SupportStuff.find_by(name: 'ddlPrerun1').value,
                                prerun2: SupportStuff.find_by(name: 'ddlPrerun2').value,
                                prerun3: SupportStuff.find_by(name: 'ddlPrerun3').value,
                                prerun4: SupportStuff.find_by(name: 'ddlPrerun4').value,
                                live_run: SupportStuff.find_by(name: 'ddlLiveRun').value,
                                live_keymap: SupportStuff.find_by(name: 'ddlLiveKeyMap').value,
                                live_batch: SupportStuff.find_by(name: 'ddlLiveBatch').value,
                                locales: SupportStuff.find_by(name: 'azkLocales').value,
                                flags: SupportStuff.find_by(name: 'ddlFlags').value,
                                location: SupportStuff.find_by(name: 'azkLocation').value
                                )
     end
  end
end

czCount = 0
['clonezilla-live-2.5.2-17-amd64', 'clonezilla-live-2.5.0-25-amd64', 'clonezilla-live-2.4.7-8-amd64', 'clonezilla-live-2.4.2-61-amd64', 'clonezilla-live-2.4.2-32-amd64', 'clonezilla-live-2.3.2-22-amd64', 'clonezilla-live-2.3.2-22-i686-pae'].each do |cz|
  ClonezillaVersion.create(name: cz,
                           is_enabled: 1,
                           upload_id: czCount += 1,
                           download_id: czCount += 1
                           )
end

ImageType.create(is_enabled: 1, name: 'DDLC-Ship')
ImageType.create(is_enabled: 1, name: 'iDDR')
ImageType.create(is_enabled: 1, name: 'OOBE')
ImageType.create(is_enabled: 1, name: 'Test')
ImageType.create(is_enabled: 1, name: 'Gold')
ImageType.create(is_enabled: 1, name: 'Custom_OS')
ImageType.create(is_enabled: 1, name: 'Event')