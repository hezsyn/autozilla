module Grub
    module Generate
        include Grub::Settings

            def genGrubCFG
            settings

            woo = grubDefaults

            woo += configFile("/live/support/gfx.cfg")

            woo += startEntry("Downloads")
                woo += configFile("/live/image/download/main.grub")
            woo += endEntry

            woo += startEntry("Uploads")
                woo += configFile("/live/image/upload/main.grub")
            woo += endEntry

            woo += breakwTitle("Tools")

            woo += startEntry("Update FD Clonezilla - Self update")
                woo += configFile("/live/support/selfupdate.grub")
            woo += endEntry

            woo += startEntry("Clonezilla Live")
                woo += configFile("/live/support/cz.grub")
            woo += endEntry

            woo += startEntry("ADS")
                woo += configFile("/live/support/ads.grub")
            woo += endEntry
        end

        def genGFX(bg, normal, hightlight)
            woo = setBG(bg) 
            woo += setColor(normal, hightlight)
        end

        def genCZCFG(cz, czValues)
            settings

            woo = startEntry(cz.name)
                woo += czVar(cz.name)
                woo += linux
                woo += parameters(czValues.params_set)
                woo += edd(czValues.edd)
                woo += liverun("ocs-live-general")
                woo += vga("788")
                woo += ram("filesystem.squashfs")
                woo += net("0")
                woo += fsLocation
                woo += initrd
            woo += endEntry
        end

        def genADSCFG
            
        end

        def genSelfUpdate
            settings

            cz = ClonezillaVersion.find_by_default(1).upload

            woo = startEntry("Autozilla Self Update")
                woo += parameters(cz.params_set)
                woo += edd(cz.edd)
                woo += locales(cz.locales)
        end

        def genDLImage
            
        end

        def genUpLImage
            
        end

    end
end