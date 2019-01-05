    module Azk
        module Key
            include Grub::Generate
            require 'fileutils'

            def setSettings
                @fu = FileUtils

                #Setting the folder locations
                @root = SupportStuff.find_by_name("rootDir").value + '/'
                @ads = @root + "adsSource"
                @cz = @root + "czSource"
                @grub = @root + "grubSource"
                @prodKey = @root + "production"
                @download = @root + "live/image/download"
                @upload = @root + "live/image/upload"
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

            def copyCZFiles
                setSettings

                puts "Copying CZ data to folder"
                @fu.cp_r "#{@cz}/.", "#{@prodKey}/live/clonezilla/" 
                puts "Complete - CZ Copy"
            end

            def genGrubStructure
                setSettings

                @fu.cd @prodKey + '/boot/grub'
                grub = File.new("grub.cfg", "w+")
                    grub.puts genGrubCFG
                grub.close

                @fu.cd @prodKey + '/live/support'
                normalGFX = File.new("gfx.cfg", "w+")
                    normalGFX.puts genGFX("bg.png", "cyan/blue", "white/blue")
                normalGFX.close

                downloadGFX = File.new("gfx_download.cfg", "w+")
                    downloadGFX.puts genGFX("bg_download.png", "cyan/blue", "white/blue")
                downloadGFX.close

                uploadGFX = File.new("gfx_upload.cfg", "w+")
                    uploadGFX.puts genGFX("bg_upload.png", "cyan/blue", "white/blue")
                uploadGFX.close

                cz = File.new("cz.grub", "w+")
                    # Creates the PXE vs FD logic
                    cz.puts bootMethod
                    ClonezillaVersion.where(is_enabled: 1).each do |czEntry|
                        cz.puts genCZCFG(czEntry, czEntry.upload)
                    end
                cz.close
                
                ads = File.new("ads.grub", "w+")
                    ads.puts genADSCFG
                ads.close

                selfupdate = File.new("selfupdate.grub", "w+")
                    selfupdate.puts genSelfUpdate
                selfupdate.close
            end

            def updateCZCFG
                setSettings

                @fu.cd @prodKey + '/live/support'
                @fu.rm 'cz.grub'

                cz = File.new("cz.grub", "w+")
                    # Creates the PXE vs FD logic
                    cz.puts bootMethod
                    ClonezillaVersion.where(is_enabled: 1).each do |czEntry|
                        cz.puts genCZCFG(czEntry, czEntry.upload)
                    end
                cz.close
            end

    end
end