module Grub
    module Generate
        include Grub::Settings

        def genGrubCFG
            settings

            woo = grubDefaults

            woo += configFile("/live/support/gfx.cfg")

            woo += genCF("Downloads", "/live/image/download/main.grub")

            woo += genCF("Uploads", "/live/image/upload/main.grub")

            woo += breakwTitle("Tools")

            woo += "if test \$pxe_default_server -eq \" \"; then\n"
                woo += genSelfUpdate
            woo += "fi\n"

            woo += genCF("Clonezilla Live", "/live/support/cz.grub")

            woo += genCF("ADS", "/live/support/ads.grub")
        end# End of genGrubCFG

        def genGFX(bg, normal, hightlight)
            woo = setBG(bg) 
            woo += setColor(normal, hightlight)
        end# End of genGFX

        def genCZCFG(cz, czValues)
            settings

            woo = startEntry(cz.name)
                woo += czVar(cz.name)
                woo += linux
                woo += bootSet
                woo += parameters(czValues.params_set)
                woo += edd(czValues.edd)
                woo += locales(czValues.locales)
                woo += keyboard("NONE")
                woo += liverun("ocs-live-general")
                woo += vga("788")
                woo += ram("filesystem.squashfs")
                woo += net("0")
                woo += fsLocation
                woo += initrd
            woo += endEntry
        end# End of genCZCFG

        def genADSCFG
            
        end

        def genSelfUpdate
            settings

            cz = ClonezillaVersion.find_by_default(1)
            czd = cz.download

            woo = startEntry("Autozilla Self Update")
                woo += czVar(cz.name)
                woo += linux
                woo += bootSet
                woo += parameters(cz.upload.params_set)
                woo += edd(czd.edd)
                woo += locales(czd.locales)
                woo += keyboard("NONE")                
                woo += prerun(01, "sudo dhclient -v")
                woo += prerun(02, "sudo mount -t cifs -v //idd-autozilla.hf.intel.com/Azk /mnt -o guest,ro")
                woo += prerun(03, "sudo mount -n -o remount,rw /lib/live/mount/medium/")
                woo += liverun("sudo rsync -rvzt --size-only /mnt/live/clonezilla/ /lib/live/mount/medium/live/clonezilla/")
                woo += postrun(01,"sudo rsync -rvzt /mnt/live/image /lib/live/mount/medium/live/image/")
                woo += postrun(02,"sudo rsync -rvzt /mnt/live/support /lib/live/mount/medium/live/support/")
                woo += postrun(03,"sudo sync")
                woo += postrun(04,"sudo reboot -f")
                woo += vga(788)
                woo += net(0)
                woo += path
                woo += initrd
            woo += endEntry

            return woo
        end# End of Self Update

        def genCategoryFile(cat, dir)
            woo = genCF("Return to Grub Menu", "/boot/grub/grub.cfg")

            if cat.category != nil
                woo += genCF("Back to #{cat.category.name}", "/live/image/#{dir}/#{cat.category.filename}")
            else 
                woo += genCF("Back to Main Page", "/live/image/#{dir}/main.grub")
            end

            if cat.categories.any?
                woo += breakwTitle("Categories")

                cat.categories.each do |subcat|
                    woo += genCF(subcat.name, "/live/image/#{dir}/#{subcat.filename}")
                end
            end

            if cat.systems.any?
                woo += breakwTitle("Systems")

                cat.systems.each do |sys|
                    woo += genCF(sys.name, "/live/image/#{dir}/#{sys.filename}")
                end# End of systems loop
            end# End of if system conditional

            return woo
        end# End of genCatFile

        def genSystemFile(sys, dir)
            woo = bootMethod

            woo += genCF("Return to Grub Menu", "/boot/grub/grub.cfg")

            if sys.category != nil
                woo += genCF("Back to #{sys.category.name}", "/live/image/#{dir}/#{sys.category.filename}")
            else 
                woo += genCF("Back to Main Page", "/live/image/#{dir}/main.grub")
            end
          
           sys.images.each do |img|
                woo += genImageEntry(img, dir)
            end 

            return woo
        end#End of genSysFile

        def genImageEntry(img, dir)
            settings

            dir == "download" ? tal = img.download : tal = img.upload

            woo = startEntry(img.name)
                woo += czVar(img.clonezilla_version.name)
                woo += linux
                woo += bootSet
                woo += parameters(tal.params_set)
                woo += edd(tal.edd)
                woo += locales(tal.locales)
                woo += keyboard("NONE")
                woo += prerun("01", tal.prerun0)
                woo += prerun("02", tal.prerun1)
                woo += prerun("03", tal.prerun2)
                woo += prerun("04", tal.prerun3)
                woo += prerun("05", tal.prerun4)
                woo += liverun(tal.live_run)
                woo += postrun("01", tal.postrun0)
                woo += postrun("02", tal.postrun1)
                woo += postrun("03", tal.postrun2)
                woo += postrun("04", tal.postrun3)
                woo += postrun("05", tal.postrun4)
                woo += liverun(tal.live_run)
                woo += vga("788")
                woo += ram("filesystem.squashfs")
                woo += net("0")
                woo += fsLocation
                woo += initrd
            woo += endEntry

            return woo
        end# End of  genImageEntry

        def genCF(title, location)
            woo = startEntry(title)
                woo += configFile(location)
            woo += endEntry
        end# End of genCF

    end # End of Generate Module
end# End of Grub Module