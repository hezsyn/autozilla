module Azk
  module Key
    require 'fileutils'

    # Section of reused to create the code
    # setSettings to create initial settings for each module
    def setSettings
      @@fut = FileUtils
      @@rootDir = SupportStuff.find_by(name: "rootKeyDir").value + '/'
      @@sourceDir = @@rootDir +  SupportStuff.find_by(name: "sourceKey").value
      @@productionDir = @@rootDir +  SupportStuff.find_by(name: "productionKey").value
      # cz = Clonezilla
      @@czSource = @@rootDir + SupportStuff.find_by(name: "czSource").value
      @@czProduction = @@rootDir + SupportStuff.find_by(name: "czProduction").value

      @@default = "\"0\""
      @@prefix = "/live"
    end

    # Helps seperate categories and systems in an entry
    def breakEntry
      @@menuEntry.puts "*=======================================================================*\n\n"
    end

    # Creates the header area of the file initially
    def grubDefault(direction)
      @@menuEntry.puts "set default=#{@@default}"
      if direction == "download"
        @@menuEntry.puts "configfile /EFI/boot/graphics.cfg\n\n"
      else
        @@menuEntry.puts "configfile /EFI/boot/graphics_upload.cfg\n\n"
      end
    end

    def sysLinuxDefault(direction)
      if direction == "download"
        @@menuEntry.puts "INCLUDE /EFI/boot/graphics.cfg\n\n"
      else
        @@menuEntry.puts "INCLUDE /EFI/boot/graphics_upload.cfg\n\n"
      end
    end


    # This is the magic, creates the boot parameters
    # surCom is the commands from autozillaConfigKey table associated with the image
    def azkCommand(surCom, direction, tool)
      # Making it easier, some variables used throughtout the method
      cz = self.clonezilla_version
      pool = self.pool.name
      filePath = self.file_location
      netPath = self.location.location
      czPath = "#{@@prefix}/CloneZilla/#{cz.name}"

      # Default starting point, that changes depending on tool
      tool == "grub" ? @@azkCom = "#{czPath}/vmlinuz " : @@azkCom = "#{czPath}/initrd.img "
      @@azkCom.concat("boot=live username=user union=overlay ")
      @@azkCom.concat(surCom.params_set.present? ? "#{surCom.params_set}"     : "#{cz.params_set}")
      @@azkCom.concat("edd=", surCom.edd.present? ? "#{surCom.edd}"             : "#{cz.edd}")
      @@azkCom.concat("keyboard-layouts=NONE ")
      if direction == "upload"
        surCom.prerun0.present? ?       @@azkCom +=  "ocs_prerun=\"#{surCom.prerun0}\""            : @@azkCom += "ocs_prerun=\"#{cz.upload.prerun0}\""
        surCom.prerun1.present? ?       @@azkCom +=  "ocs_prerun1=\"#{surCom.prerun1}\""           : @@azkCom += "ocs_prerun1=\"#{cz.upload.prerun1}\""
        surCom.prerun2.present? ?       @@azkCom +=  "ocs_prerun2=\"#{surCom.prerun2}\""           : @@azkCom += "ocs_prerun2=\"#{cz.upload.prerun2}\""
        surCom.prerun3.present? ?       @@azkCom +=  "ocs_prerun3=\"#{surCom.prerun3}\""           : @@azkCom += "ocs_prerun3=\"#{cz.upload.prerun3}\""
        surCom.prerun4.present? ?       @@azkCom +=  "ocs_prerun4=\"#{surCom.prerun4}\""           : @@azkCom += "ocs_prerun4=\"#{cz.upload.prerun4}\""
        surCom.live_run.present? ?      @@azkCom +=  "ocs_live_run=\"#{surCom.live_run}\""         : @@azkCom += "ocs_live_run=\"#{cz.upload.live_run}\""
        surCom.live_keymap.present? ?   @@azkCom +=  "ocs_live_keymap=\"#{surCom.live_keymap}\""   : @@azkCom += "ocs_live_keymap=\"#{cz.upload.live_keymap}\""
        surCom.live_param.present? ?    @@azkCom +=  "ocs_live_param=\"#{surCom.live_param}\""     : @@azkCom += "ocs_live_param=\"#{cz.upload.live_param}\""
        surCom.live_batch.present? ?    @@azkCom +=  "ocs_live_batch=\"#{surCom.live_batch}\""     : @@azkCom += "ocs_live_batch=\"#{cz.upload.live_batch}\""
        surCom.postrun0.present? ?      @@azkCom +=  "ocs_postrun=\"#{surCom.postrun0}\""          : @@azkCom += "ocs_postrun0=\"#{cz.upload.postrun0}\""
        surCom.postrun1.present? ?      @@azkCom +=  "ocs_postrun1=\"#{surCom.postrun1}\""         : @@azkCom += "ocs_postrun1=\"#{cz.upload.postrun1}\""
        surCom.postrun2.present? ?      @@azkCom +=  "ocs_postrun2=\"#{surCom.postrun2}\""         : @@azkCom += "ocs_postrun2=\"#{cz.upload.postrun2}\""
        surCom.postrun3.present? ?      @@azkCom +=  "ocs_postrun3=\"#{surCom.postrun3}\""         : @@azkCom += "ocs_postrun3=\"#{cz.upload.postrun3}\""
        surCom.postrun4.present? ?      @@azkCom +=  "ocs_postrun4=\"#{surCom.postrun4}\""         : @@azkCom += "ocs_postrun4=\"#{cz.upload.postrun4}\""
        surCom.locales.present? ?       @@azkCom +=  "locales=\"#{surCom.locales}\""               : @@azkCom += "locales=\"#{cz.upload.locales}\""
      else
        surCom.prerun0.present? ?       @@azkCom +=  "ocs_prerun=\"#{surCom.prerun0}\""            : @@azkCom += "ocs_prerun=\"#{cz.download.prerun0}\""
        surCom.prerun1.present? ?       @@azkCom +=  "ocs_prerun1=\"#{surCom.prerun1}\""           : @@azkCom += "ocs_prerun1=\"#{cz.download.prerun1}\""
        surCom.prerun2.present? ?       @@azkCom +=  "ocs_prerun2=\"#{surCom.prerun2}\""           : @@azkCom += "ocs_prerun2=\"#{cz.download.prerun2}\""
        surCom.prerun3.present? ?       @@azkCom +=  "ocs_prerun3=\"#{surCom.prerun3}\""           : @@azkCom += "ocs_prerun3=\"#{cz.download.prerun3}\""
        surCom.prerun4.present? ?       @@azkCom +=  "ocs_prerun4=\"#{surCom.prerun4}\""           : @@azkCom += "ocs_prerun4=\"#{cz.download.prerun4}\""
        surCom.live_run.present? ?      @@azkCom +=  "ocs_live_run=\"#{surCom.live_run}\""         : @@azkCom += "ocs_live_run=\"#{cz.download.live_run}\""
        surCom.live_keymap.present? ?   @@azkCom +=  "ocs_live_keymap=\"#{surCom.live_keymap}\""   : @@azkCom += "ocs_live_keymap=\"#{cz.download.live_keymap}\""
        surCom.live_param.present? ?    @@azkCom +=  "ocs_live_param=\"#{surCom.live_param}\""     : @@azkCom += "ocs_live_param=\"#{cz.download.live_param}\""
        surCom.live_batch.present? ?    @@azkCom +=  "ocs_live_batch=\"#{surCom.live_batch}\""     : @@azkCom += "ocs_live_batch=\"#{cz.download.live_batch}\""
        surCom.postrun0.present? ?      @@azkCom +=  "ocs_postrun=\"#{surCom.postrun0}\""          : @@azkCom += "ocs_postrun=\"#{cz.download.postrun0}\""
        surCom.postrun1.present? ?      @@azkCom +=  "ocs_postrun1=\"#{surCom.postrun1}\""         : @@azkCom += "ocs_postrun1=\"#{cz.download.postrun1}\""
        surCom.postrun2.present? ?      @@azkCom +=  "ocs_postrun2=\"#{surCom.postrun2}\""         : @@azkCom += "ocs_postrun2=\"#{cz.download.postrun2}\""
        surCom.postrun3.present? ?      @@azkCom +=  "ocs_postrun3=\"#{surCom.postrun3}\""         : @@azkCom += "ocs_postrun3=\"#{cz.download.postrun3}\""
        surCom.postrun4.present? ?      @@azkCom +=  "ocs_postrun4=\"#{surCom.postrun4}\""         : @@azkCom += "ocs_postrun4=\"#{cz.download.postrun4}\""
        surCom.locales.present? ?       @@azkCom +=  "locales=\"#{surCom.locales}\""               : @@azkCom += "locales=\"#{cz.download.locales}\""
      end
      @@azkCom.concat("vga=788 net.ifnames=0 toram=filesystem.squashfs live-media-path=#{czPath} ")
      tool == "grub" ? @@azkCom += "\n\s\sinitrd #{czPath}/initrd.img" : nil
      @@azkCom = eval '"' + @@azkCom.gsub('"', '\"') + '"'
    end

    def czAZKCom(cz, tool, purpose)
      czPath = "#{@@prefix}/CloneZilla/#{cz.name}"

      if purpose == "grub" || tool == "syslinux"
        tool == "grub" ? rawCZCom = "#{czPath}/vmlinuz\\" : rawCZCom = "#{czPath}/initrd.img"
        rawCZCom += "\n\s\s\sboot=live union=overlay username=user\\\n" \
                  "\s\s\sconfig components nointremap noswap nomodeset nodmraid noeject nosplash\\\n" \
                  "\s\s\sedd=on\\\n" \
                  "\s\s\slocales=en_US.UTF-8\\\n" \
                  "\s\s\skeyboard-layouts=NONE\\\n" \
                  "\s\s\socs_live_run=\"ocs-live-general\"\\\n" \
                  "\s\s\socs_live_batch=no\\\n" \
                  "\s\s\svga=788\\\n" \
                  "\s\s\storam=filesystem.squashfs\\\n" \
                  "\s\s\snet.ifnames=0\\\n" \
                  "\s\s\si915.blacklist=yes\\\n" \
                  "\s\s\sradeonhd.blacklist=yes\\\n" \
                  "\s\s\snouveau.blacklist=yes\\\n" \
                  "\s\s\svmwgfx.enable_fbdev=1\\\n" \
                  "\s\s\slive-media-path=#{czPath}"
        tool == "grub" ? rawCZCom += "\n\s\sinitrd #{czPath}/initrd.img" : nil
      end

      if purpose == "selfupdate"
        tool == "grub" ? rawCZCom = "#{czPath}/vmlinuz\\" : rawCZCom = "#{czPath}/initrd.img"
        rawCZCom += "\n\s\s\sboot=live union=overlay username=user\\\n" \
                  "\s\s\sconfig components noswap nomodeset nodmraid noeject nosplash\\\n" \
                  "\s\s\sedd=on\\\n" \
                  "\s\s\slocales=en_US.UTF-8\\\n" \
                  "\s\s\skeyboard-layouts=NONE\\\n" \
                  "\s\s\socs_prerun01=\"sudo dhclient -v\"\\\n" \
                  "\s\s\socs_prerun02=\"sudo mount -t cifs -v //idds-superzilla.hf.intel.com/Azk /mnt -o guest,ro\"\\\n" \
                  "\s\s\socs_prerun03=\"sudo mount -n -o remount,rw /lib/live/mount/medium/\"\\\n" \
                  "\s\s\socs_live_run=\"sudo rsync -rvzt --size-only /mnt/live/CloneZilla/ /lib/live/mount/medium/live/CloneZilla/\"\\\n" \
                  "\s\s\socs_postrun01=\"sudo rsync -rvzt /mnt/live/download/ /lib/live/mount/medium/live/download/\"\\\n" \
                  "\s\s\socs_postrun02=\"sudo rsync -rvzt /mnt/live/upload/ /lib/live/mount/medium/live/upload/\"\\\n" \
                  "\s\s\socs_postrun03=\"sudo sync\"\\\n" \
                  "\s\s\socs_postrun02=\"sudo reboot -f\"\\\n" \
                  "\s\s\svga=788\\\n" \
                  "\s\s\snet.ifnames=0\\\n" \
                  "\s\s\slive-media-path=#{czPath}"
        rawCZCom += "\n\s\sinitrd #{czPath}/initrd.img" if tool == "grub"
      end
      rawCZCom = rawCZCom.gsub("\s\s", "\s").gsub("\n","").gsub("\\","").chomp if tool == "syslinux"
      return rawCZCom
    end

    # This takes the command above and inputs it into the file
    def grubCatMenuEntry(direction, entryType)
      @@menuEntry.puts "menuentry \"#{self.name}\" \{"
      @@menuEntry.puts "\tconfigfile #{@@prefix}/#{direction}/grub/#{entryType}_#{self.slug}.menu"
      @@menuEntry.puts "\}\n\n"
    end

    def sysCatMenuEntry(direction, entryType)
      @@menuEntry.puts "LABEL #{self.name}"
      @@menuEntry.puts "MENU LABEL #{self.name}"
      @@menuEntry.puts "KERNAL vesamenu.c32"
      @@menuEntry.puts "APPEND #{@@prefix}/#{direction}/syslinux/#{entryType}_#{self.slug}.menu\n\n"
    end

    def grubEntry(entryCom)
      @@menuEntry.print "menuentry \"#{self.name}\" \{\n"
      @@menuEntry.print "\s\slinux #{entryCom}\n"
      @@menuEntry.print "\}\n\n"
    end

    def sysEntry(entryCom)
      @@menuEntry.puts "LABEL #{self.name}"
      @@menuEntry.puts "\tMENU LABEL #{self.name}"
      @@menuEntry.puts "\tKERNEL /live/CloneZilla/#{self.clonezilla_version.name}/vmlinuz"
      @@menuEntry.puts "\tAPPEND initrd=#{entryCom}\n\n"
    end

    def azkEntry(entry, tool, purpose)
      entryCom = czAZKCom(entry, tool, purpose)
      if tool == "grub"
        if purpose == "selfupdate"
          azkCom = "menuentry \"\" \{\n\s\strue\n\}\n"
          azkCom += "\nmenuentry \"Clonezilla Self Update\" \{"
        else
          azkCom = "menuentry \"#{entry.name}\" \{"
        end
        azkCom += "\n\s\slinux #{entryCom}" \
                  "\n\}\n"
      else
        if purpose == "selfupdate"
          azkCom = "label\n"
          azkCom += "\nLABEL ClonezillaSelfUpdate\n"
        else
          azkCom = "\nLABEL #{entry.name}\n"
        end
        azkCom += "\tMENU LABEL #{entry.name}\n"  \
                  "\tKERNEL /live/CloneZilla/#{entry.name}/vmlinuz\n" \
                  "\tAPPEND initrd=#{entryCom}\n\n"
      end
    end

    # Used to create the Category entry
    def createAZKCategoryFiles
      setSettings

      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
          @@fut.cd("#{@@productionDir}/live/#{direction}/#{tool}")
          @@menuEntry = File.new("category_#{self.slug}.menu", "w+")

            tool == "grub" ? self.grubDefault(direction) : self.sysLinuxDefault(direction)

            puts self.file_location

            self.categories.order(:name).where(is_enabled: 1).each do |cat|
              tool == "grub" ? cat.grubCatMenuEntry(direction, "category") : cat.sysCatMenuEntry(direction, "category")
            end

            self.breakEntry if self.systems.present?

            self.systems.order(:name).where(is_enabled: 1).each do |sys|
              tool == "grub" ? sys.grubCatMenuEntry(direction, "system") : sys.sysCatMenuEntry(direction, "system")
            end

          @@menuEntry.close

        end
      end
    end

    # Used to create the System Entry
    def createAZKSystemFiles
      setSettings
      self.try(:category_id).nil? ? system = System.find(self.system_id) : system = System.find_by(name: self.name)

      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
          @@fut.cd("#{@@productionDir}/live/#{direction}/#{tool}")

          @@menuEntry = File.new("system_#{system.slug}.menu", "w+")
            tool == "grub" ? self.grubDefault(direction) : self.sysLinuxDefault(direction)
            system.images.order(:name).where(image_status: 1).each do |img|
              if tool == "grub"
                if direction == "upload"
                  img.azkCommand(img.upload, direction, tool)
                else
                  img.azkCommand(img.download, direction, tool)
                end
              else
                if direction == "upload"
                  img.azkCommand(img.upload, direction, tool)
                else
                  img.azkCommand(img.download, direction, tool)
                end
              end

              tool == "grub" ? img.grubEntry(@@azkCom) : img.sysEntry(@@azkCom)
            end

          @@menuEntry.close

        end
      end
    end

    def createCZEntry(tool)
      tool == "grub" ? czFile = "set prefix=/live\n\n" : czFile = "INCLUDE /syslinux/graphics.conf\n\n"
      czs = ClonezillaVersion.where(:is_enabled => 1).order(:name)

        czs.each do |cz|
          # Creates the file in czFile
          czFile += azkEntry(cz, tool, tool)
        end

        return czFile
    end

    # Creates the top level area
    def createTopLevel
      setSettings
      if File.exist? "#{@@productionDir}/live/download/grub/top.menu"
        nil
      else
      # Gathers all of the top level categories
      topLevel = Category.where(is_enabled: 1, category_id: nil)

        # Creating loops to create the 4 files necessary
        ["upload", "download"].each do |direction|
          ["grub", "syslinux"].each do |tool|

            # Changing directory to file path for file
            @@fut.cd "#{@@productionDir}/live/#{direction}/#{tool}"
            # Starting the file creation
            @@menuEntry = File.new("top.menu", "w+")

            # This line is only added once to the file, it is the default data for the file
            tool == "grub" ? grubDefault(direction) : sysLinuxDefault(direction)
            # Loops and adds all top level entries to the file
            topLevel.each do |cat|
              tool == "grub" ? cat.grubCatMenuEntry(direction, "category") : cat.sysCatMenuEntry(direction, "category")
            end

            # Like every door you open, you should close that door.  This is just closing the file.
            @@menuEntry.close
          end
        end
      end
    end

    # Destruction of the key
    # Deletes the whole production key
    def removeAZK
      setSettings
      @@fut.cd @@rootDir
      @@fut.rm_r("production") if File.exist? "production"
    end

    # This removes the previous entry file
    def removeEntry(entryType, entity)
      setSettings
      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
            # Changing directory to file path for file
            @@fut.cd("#{@@productionDir}/live/#{direction}/#{tool}")
            @@fut.rm("#{entryType}_#{entity.slug}.menu") if File.exist?("#{entryType}_#{entity.slug}.menu")
        end
      end
    end

    # Creation for the structure of the ke
    # Recreates the file structure of the system
    def createAZKDefault
      setSettings
      @@fut.cd @@rootDir
      @@fut.cp_r @@sourceDir, @@productionDir

      @@fut.cd "production/live"
      @@fut.mkdir_p %w( CloneZilla download/grub download/syslinux selfupdate upload/grub upload/syslinux)
    end

    def migrateClonezillas
      setSettings

      @@fut.cp_r @@czSource + '/.', @@czProduction

      # Navigate to working directory, production/live
      @@fut.cd @@czProduction
      ['grub', 'syslinux'].each do |tool|
        @menuEntry = File.new("live.#{tool}", "w+")
          @menuEntry.puts createCZEntry(tool)
        @menuEntry.close
      end
    end

    #-----------------------------------------------------------------
    # -------------------- Self Update Series! -----------------------
    # ----------------------------------------------------------------
    def createSelfUpdate
      setSettings
      # Find the default version of clonezilla
      cz = ClonezillaVersion.find_by(:default => 1)
      # Navigate to the folder with selfupdate
      @@fut.cd @@productionDir + '/live/selfupdate'

      # Creates a selfupdate files
      ["grub", "syslinux"].each do |tool|
        @menuEntry = File.new("selfupdate.#{tool}", "w+")
          @menuEntry.puts azkEntry(cz, tool, "selfupdate")
        @menuEntry.close
      end

    end

  end # End of Key Module
end # End of the AZK Module