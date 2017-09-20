include Azk::Key

# Setting some defaults
SupportStuff.create(name: 'appTitle', value: 'Demo Depot - AutoZilla', description: 'This is the title that is displayed throughout the application.\r\n\r\nDefault: AutoZilla, The Rapid Clonezilla Image Deployment Framework')
#SupportStuff.create(name: 'ldapBaseDn', value: 'OU=Workers,DC=amr,DC=corp,DC=intel,DC=com', description: 'This is the base DN for LDAP (Active Directory)\r\n\r\nDefault: OU=Workers,DC=amr,DC=corp,DC=intel,DC=com')
#SupportStuff.create(name: 'ldapServer', value: 'amr.corp.intel.com', description: 'This is the LDAP (Active Directory) server address.\r\n\r\nDefault: amr.glb.intel.com')
#SupportStuff.create(name: 'ldapMemberOfQuery', value: '(memberof=CN=IDD-TMEs,OU=Delegated,OU=Groups,DC=amr,DC=corp,DC=intel,DC=com)', description: 'This query dictates who can log-in. By default it only allows Intel Demo Depot TME''s (IDD-TMEs)\r\n\r\nDefault: (memberof=CN=IDD-TMEs,OU=Delegated,OU=Groups,DC=amr,DC=corp,DC=intel,DC=com)')
SupportStuff.create(name: 'clonezillaDefaultVersion', value: 'clonezilla-live-2.5.0-25-amd64', description: 'This is the default Clonezilla version.\n\nDefault: clonezilla-live-2.3.0-1-amd64-TESTING')
SupportStuff.create(name: 'imageBasePath', value: '//amr.corp.intel.com/idd/Infrastructure/CloneZilla/NAMO.OR.Loan/Images/automation', description: 'This is the base image path on the file server (Samba/Windows share).\r\n\r\nDefault: /LCGhost/Clonezilla-images')
SupportStuff.create(name: 'imageServer', value: '10.23.79.74', description: 'This is the IP, Hostname or FQDN (Fully Qualified Domain Name) of the image server (Samba/Windows share).\r\n\r\nDefault: 10.23.88.13')
SupportStuff.create(name: 'squashfsFtpServer', value: '10.23.79.70',description: 'This is the IP, Hostname or FQDN (Fully Qualified Domain Name) of the FTP server hosting the Clonezilla live versions.\r\n\r\nIMPORTANT: Root path needs to follow this convention: /boot/grub/CloneZilla/\r\n\r\nDefault: 10.23.88.19')
SupportStuff.create(name: 'defaultCloneFlagsDownload', value: '-e2 -j2 -p choose',description: 'These are the default clone flags for Clonezilla that will appear in the text input when creating new images.\r\n\r\nDefault: -e2 -j2 -p')
SupportStuff.create(name: 'AZKimageServer', value: 'amr.corp.intel.com',description: 'This is the IP, Hostname or FQDN (Fully Qualified Domain Name) of the image server (Samba/Windows share).\r\n\r\nDefault: 10.23.88.13')
SupportStuff.create(name: 'defaultCloneFlagsUpload', value: '-q2 -j2 -z1p -sc -p choose', description: 'These are the default upload clone flags for Clonezilla that will appear in the text input when creating new images.\r\n\r\nDefault: -q2 -j2 -z1p -sc -p true')
SupportStuff.create(name: 'originalKey', value: 'C:\\Staging', description: 'Location of the default version of the key')
SupportStuff.create(name: 'rootDir', value: '/mnt/c/Users/hezsy/Desktop/Staging/AZK', description: "Default location of everything")
SupportStuff.create(name: 'sourceDir', value: '/mnt/c/Users/hezsy/Desktop/Staging/AZK/source', description: "Source directory for setting up key")


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
Category.all.each do |cat|
  cat.file_location = cat.objectLocation
  cat.save
end
# Creates the top.menu
# createTopLevel

Pool.create(is_enabled: 1, name: "USDD" )
Pool.create(is_enabled: 1, name: "APAC" )
Pool.create(is_enabled: 1, name: "SAP" )
Pool.create(is_enabled: 1, name: "Intel_Education" )
Pool.create(is_enabled: 1, name: "ASEP" )
Pool.create(is_enabled: 1, name: "PCSD" )
Pool.create(is_enabled: 1, name: "ABCD" )
Pool.create(is_enabled: 1, name: "DCG_VMW_GTM" )
Pool.create(is_enabled: 1, name: "ARPS" )
Pool.create(is_enabled: 1, name: "ETSP" )
Pool.create(is_enabled: 1, name: "VCA" )
Pool.create(is_enabled: 1, name: "MIP" )
Pool.create(is_enabled: 1, name: "IEM" )
Pool.create(is_enabled: 1, name: "RSD" )
Pool.create(is_enabled: 1, name: "STLP" )
Pool.create(is_enabled: 1, name: "EXTERNAL" )
Pool.create(is_enabled: 1, name: "IOTG" )
Pool.create(is_enabled: 1, name: "PSMSP" )

Ose.create(is_enabled: 1, name: "Linux | Wind River" )
Ose.create(is_enabled: 1, name: "Linux | Ubuntu" )
Ose.create(is_enabled: 1, name: "Linux | CentOS" )
Ose.create(is_enabled: 1, name: "Win 7 Ent | 32-Bit | KMS " )
Ose.create(is_enabled: 1, name: "Win 7 Pro | 64-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 7 Pro | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 7 Ent | 64-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 8.1 | 32-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 8.1 | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 8.1 w/ Bing | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 8.1 w/ Bing | 32-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 8.1 Pro | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 8.1 Pro | 32-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 8.1 Pro | 64-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 8.1 Pro | 32-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 8.1 Ent | 32-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 8.1 Ent | 64-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 8.1 Ent | 64-Bit | MAK" )
Ose.create(is_enabled: 1, name: "Win 8.1 Ent | 32-Bit | MAK" )
Ose.create(is_enabled: 1, name: "Win 2012R2 Data Update | KMS" )
Ose.create(is_enabled: 1, name: "Win 2012R2 Data | KMS" )
Ose.create(is_enabled: 1, name: "Win 2012R2 Std | KMS" )
Ose.create(is_enabled: 1, name: "Win 10 Home | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 10 Home | 32-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 10 Home | 64-Bit | Upgrade (OEM)" )
Ose.create(is_enabled: 1, name: "Win 10 Home | 32-Bit | Upgrade (OEM)" )
Ose.create(is_enabled: 1, name: "Win 10 Pro | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 10 Pro | 32-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Win 10 Pro | 64-Bit | Upgrade (OEM)" )
Ose.create(is_enabled: 1, name: "Win 10 Pro | 32-Bit | Upgrade (OEM)" )
Ose.create(is_enabled: 1, name: "Win 10 Pro | 64-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 10 Pro | 32-Bit | KMS " )
Ose.create(is_enabled: 1, name: "Win 10 Ent | 64-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 10 Ent | 32-Bit | KMS" )
Ose.create(is_enabled: 1, name: "Win 10 Ent LTSB | 64-Bit | OEM" )
Ose.create(is_enabled: 1, name: "Other | Customer OS" )

ImageStatus.create(is_visible: 1, name: "Production" )
ImageStatus.create(is_visible: 1, name: "Obsolete" )
ImageStatus.create(is_visible: 1, name: "Gold Image" )
ImageStatus.create(is_visible: 1, name: "Development" )
ImageStatus.create(is_visible: 1, name: "Test Image" )


6.times do
  ["upload", "download"].each do |direction|
    ["grub", "syslinux"].each do |tool|
      AutozillaKeyConfig.create(btldr: tool,
                            purpose: direction,
                            params_set: 'components config noswap nolocales nodmraid nomodeset nointremap nosplash noprompt',
                            edd: 'on',
                            flags_upload: SupportStuff.find_by(name: "defaultCloneFlagsUpload").value,
                            flags_download: SupportStuff.find_by(name: "defaultCloneFlagsDownload").value
                            )
    end
  end
end

ClonezillaVersion.create(name: 'clonezilla-live-2.5.0-25-amd64',    description: '', is_enabled: 1, grub_upload_id: 1,  grub_download_id: 2,  syslinux_upload_id: 3,  syslinux_download_id: 4)
ClonezillaVersion.create(name: 'clonezilla-live-2.4.7-8-amd64',     description: '', is_enabled: 1, grub_upload_id: 5,  grub_download_id: 6,  syslinux_upload_id: 7,  syslinux_download_id: 8)
ClonezillaVersion.create(name: 'clonezilla-live-2.4.2-61-amd64',    description: '', is_enabled: 1, grub_upload_id: 9,  grub_download_id: 10, syslinux_upload_id: 11, syslinux_download_id: 12)
ClonezillaVersion.create(name: 'clonezilla-live-2.4.2-32-amd64',    description: '', is_enabled: 1, grub_upload_id: 13, grub_download_id: 14, syslinux_upload_id: 15, syslinux_download_id: 16)
ClonezillaVersion.create(name: 'clonezilla-live-2.3.2-22-amd64',    description: '', is_enabled: 1, grub_upload_id: 17, grub_download_id: 18, syslinux_upload_id: 19, syslinux_download_id: 20)
ClonezillaVersion.create(name: 'clonezilla-live-2.3.2-22-i686-pae', description: '', is_enabled: 1, grub_upload_id: 21, grub_download_id: 22, syslinux_upload_id: 23, syslinux_download_id: 24)

ImageType.create(is_enabled: 1, name: 'DDLC-Ship')
ImageType.create(is_enabled: 1, name: 'iDDR')
ImageType.create(is_enabled: 1, name: 'OOBE')
ImageType.create(is_enabled: 1, name: 'Test')
ImageType.create(is_enabled: 1, name: 'Gold')
ImageType.create(is_enabled: 1, name: 'Custom_OS')
ImageType.create(is_enabled: 1, name: 'Event')