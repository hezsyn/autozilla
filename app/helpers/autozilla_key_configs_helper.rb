module AutozillaKeyConfigsHelper
    require 'fileutils'
    require 'zip'
    require 'grubentries'

    def setSettings
        @fu = FileUtils

        #Setting the folder locations
        @root = SupportStuff.find_by_name("rootDir").value + '/'
        @ads = @root + "adsSource"
        @cz = @root + "czSource"
        @grub = @root + "grubSource"
        @prodKey = @root + "production"
    end

    def destroyStructure
        setSettings
        
       @fu.cd @prodKey

       puts "Removing boot EFI and live datas"
        @fu.rm_r "boot" if File.exist? "boot"
        @fu.rm_r "EFI" if File.exist? "EFI"
        @fu.cd "live"
        @fu.rm_r "ads" if File.exist? "ads"
        @fu.rm_r "clonezilla" if File.exist? "clonezilla"
        @fu.rm_r "imaging" if File.exist? "imaging"
        @fu.rm_r "support" if File.exist? "support"
        puts "Complete"

    end

    def createStructure
        setSettings

        # Creation of the base files for grub
        @fu.cd @prodKey
        puts "Creating grub structure folder"
        @fu.mkdir_p %w( boot/grub EFI/boot )
        puts "Complete grub structure"
        
        # Creation of the Live Structure
        @fu.cd "live"
        puts "Creating live folder selection"
        @fu.mkdir_p %w( ads clonezilla support imaging/upload imaging/download )
        puts "Creation of the live folder creation complete"

    end

    def copyAllUncreatable
        setSettings

        # Copy files for key
        @fu.cd @grub
        puts "Coping all EFI files from grub folder"
        @fu.cp %w(  bootia32.efi bootx64.efi grub64.efi grubx64.efi ) , "#{@prodKey}/EFI/boot"
        puts "Complete transfer of EFI files"

        puts "Coping all pictures to support"
        @fu.cp %w( bg.png bg_upload.png bg_download.png ), "#{@prodKey}/live/support"
        puts "Complete transfer of pictures to support"

        puts "Coping unicode.pf2 to support folder"
        @fu.cp "#{@grub}/unicode.pf2", "#{@prodKey}/live/support"
        puts "Complete transfer of unicode to support"
    end

    def genGrubStructure
        setSettings

        
    end

end
