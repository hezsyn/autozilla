module Grub
    module Settings
        #These are used in lines to change the formatting
        def settings
            @preLine = "\n\s\s"
            @apLine = " \\"
        end

        def grubDefaults
            "set default=0" \
            "\nif loadfont /live/support/unicode.pf2\; then" \
            "\n\s\sset gfxmode=1024x768x32" \
            "\n\s\sinsmod efi_gop" \
            "\n\s\sinsmod efi_uga" \
            "\n\s\sinsmod gfxterm" \
            "\n\s\sterminal_output gfxterm" \
            "\nfi" \
            "\nset timeout=\"-1\"" \
            "\nset hidden_timeout_quiet=false\n" 
        end    

        #Start of the menuEntry
        def startEntry(value)
             "\nmenuentry \"#{value}\" \{"
        end

        def endEntry
             "\n\}\n"
        end

        def openFW
             "\s\s"
        end

        def rebootCP
             "\s\sreboot\n"
        end

        def breaknTitle
            "\nmenuentry \"<================================================>\" {\n" \
            "}\n"
        end

        def breakwTitle(value) 
            "\nmenuentry \"<==========================-#{value}-======================>\" {\n" \
            "}\n"
        end

        def configFile(value)
             "\n\s\sconfigfile #{value}"
        end

        def setBG(value)
             "background_image /live/support/#{value}"
        end

        def setColor(normal, hightlight)
             "\nset color_normal=#{normal}" \
             "\nset color_highlight=#{hightlight}"
        end

        def bootMethod
            "if test \$pxe_default_server -eq \" \"; then\n" \
            "\s\sset fs_location=\"live-media-path=/live/Clonezilla\"\n" \
            "else\n" \
            "\s\sset fs_location=\"fetch=http://idds-adsboot02.amr.corp.intel.com/clonezilla\"\n" \
            "\s\sset fs_file=\"/filesystem.squashfs\"\n" \
            "fi\n" 
        end

        def czVar(value)
             "#{@preLine}set  cz=#{value}#{@apLine}"
        end

        def linux
             "#{@preLine}linux /live/clonezilla/\$cz/vmlinuz#{@apLine}"
        end

        def bootSet
            "#{@preLine}boot=live, union=overlay username=user#{@apLine}"
        end

        def parameters(value)
             "#{@preLine}#{value}#{@apLine}"
        end

        def edd(value)
             "#{@preLine}edd=#{value}#{@apLine}"
        end

        def keyboard(value)
             "#{@preLine}keyboard-layouts=#{value}#{@apLine}"
        end

        def prerun(count, value)
             "#{@preLine}ocs_prerun#{count}=\"#{value}\"#{@apLine}"
        end

        def liverun(value)
             "#{@preLine}ocs_live_run=\"#{value}\"#{@apLine}"
        end

        def keymap(value)
             "#{@preLine}ocs_live_keymap=\"#{value}\"#{@apLine}"       
        end

        def param(value)
             "#{@preLine}ocs_live_param=\"#{value}\"#{@apLine}"        
        end

        def batch(value)
             "#{@preLine}ocs_live_batch=\"#{value}\"#{@apLine}"        
        end

        def postrun(count, value)
             "#{@preLine}ocs_postrun#{count}=\"#{value}\"#{@apLine}"
        end

        def locales(value)
             "#{@preLine}locales=\"#{value}\"#{@apLine}"
        end

        def vga(value)
             "#{@preLine}vga=#{value}#{@apLine}"
        end

        def net(value)
             "#{@preLine}net.ifnames=#{value}#{@apLine}"
        end

        def ram(value)
             "#{@preLine}toram=#{value}#{@apLine}"
        end

        def fsLocation
             "#{@preLine}\$fs_location/\$cz\$fs_file#"
        end

        def path
            "#{@preLine}live-media-path=/live/clonezilla/\$cz"
        end

        def initrd
             "#{@preLine}initrd /live/clonezilla/\$cz/initrd.img"
        end

    end
end