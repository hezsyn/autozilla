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
                @imageLoc = @prodKey +"/live/image/"
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
                    @fu.rm_r "image" if File.exist? "image"
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
                @fu.mkdir_p %w( ads clonezilla support image/upload image/download )
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
            end

            def createTopMenu
                setSettings

                topCats = Category.where(category_id: nil, is_enabled: 1).order(:name)

                # create Top Level for download
                ["download", "upload"].each do |dir|
                    puts "Create #{dir} top menu"
                    @fu.cd @imageLoc + dir
                        file = File.new("main.grub", "w+")
                            if dir == "upload"
                                file.print setBG("/live/support/bg_upload.png")
                                file.puts setColor("white/blue", "green/yellow")
                            else 
                                file.print setBG("/live/support/bg_download.png.png")
                                file.puts setColor("white/blue", "green/yellow")
                            end

                            topCats.each do |cat|
                                file.print genCF(cat.name, "/live/image/#{dir}/#{cat.filename}")
                            end
                        file.close
                    puts "Complete"
                end
            end

            def createCategoryFiles
                setSettings

                categories = Category.where(is_enabled: 1)

                ["download", "upload"].each do |dir|
                    @fu.cd @imageLoc + dir
                        
                        categories.each do |cat|
                            file = File.new(cat.filename, "w+")
                                file.print genCategoryFile(cat, dir)
                            file.close
                        end# End of Categories loop

                end# End of download / upload loop
            end# End of createCategoryFiles

            def createSystemFiles
                setSettings
                
                ["download", "upload"].each do |dir|
                    @fu.cd @imageLoc + dir

                        systems = System.where(is_enabled: 1)

                        systems.each do |sys|
                            file = File.new(sys.filename, "w+")
                                file.print genSystemFile(sys, dir)
                            file.close # Close of the file
                        end # End of system loop

                end# End of download / upload loop
            end# End of createSystemFiles

            def createCategoryFile(cat)
                setSettings

                ["download", "upload"].each do |dir|
                    @fu.cd @imageLoc + dir
                        @fu.rm cat.filename if File.exist? cat.filename
                        @fu.rm cat.category.filename if File.exist? cat.category.filename

                            #Regenerating the parent Category file
                            file = File.new(cat.category.filename, "w+")
                                file.print genCategoryFile(cat.category, dir)
                            file.close

                            #Creating the called for category file
                            file = File.new(cat.filename, "w+")
                                file.print genCategoryFile(cat, dir)
                            file.close
                end# End of the download/upload loop

            end# End of createCatFile

            def createSystemFile(sys)
                setSettings

                ["download", "upload"].each do |dir|
                    @fu.cd @imageLoc + dir
                        @fu.rm sys.filename if File.exist? sys.filename
                        @fu.rm sys.category.filename if File.exist? sys.category.filename

                            file = File.new(sys.category.filename, "w+")
                                file.print genCategoryFile(sys.category, dir)
                            file.close

                            file = File.new(sys.filename, "w+")
                                file.print genSystemFile(sys, dir)
                            file.close

                end# End of D/L loop
            end# End of createSysFile

            def updateCZCFG
                setSettings

                @fu.cd @prodKey + '/live/support'
                @fu.rm 'cz.grub'

                cz = File.new("cz.grub", "w+")
                    # Creates the PXE vs FD logic
                    cz.puts bootMethod
                    ClonezillaVersion.where(is_enabled: 1).each do |czEntry|
                        cz.puts genCZCFG(czEntry, czEntry.upload)
                    end# End of ClonezillaVersion
                cz.close
            end # End of updateCZCFG

            def destroyCategoryFile(cat)
                setSettings

                ["download", "upload"].each do |dir|
                    @fu.cd @imageLoc + dir
                        @fu.rm cat.filename if File.exist? cat.filename
                        @fu.rm cat.category.filename if File.exist? cat.category.filename

                        file = File.new(cat.category.filename, "w+")
                            file.print genCategoryFile(cat.category, dir)
                        file.close

                end# End of download/upload loop
            end# End of destroyCatFile

            def destroySystemFile(sys)
                setSettings

                ["download", "upload"].each do |dir|
                    @fu.cd @imageLoc + dir
                        @fu.rm sys.filename if File.exist? sys.filename
                        @fu.rm sys.category.filename if File.exist? sys.category.filename

                        file = File.new(sys.category.filename, "w+")
                            file.print genCategoryFile(sys.category, dir)
                        file.close
                end# End of D/U loop
            end

    end # End of Key Module
end # End of AZK Module