module Azk
  module Key
    require 'fileutils'

    @@fut = FileUtils
    @@rootDir = "/mnt/c/Users/hezsy/Desktop/Staging/AZK"
    @@sourceDir = "/mnt/c/Users/hezsy/Desktop/Staging/AZK/source"

    @@default = "\"0\""
    @@prefix = "/live"

    def breakEntry
      @@menuEntry.puts "*=======================================================================*\n\n"
    end

    def grubDefault
      @@menuEntry.puts "set default=\"#{@@default}\""
      @@menuEntry.puts "configfile /EFI/boot/graphics.cfg\n\n"
    end

    def sysLinuxDefault
      @@menuEntry.puts "INCLUDE /syslinux/graphics.conf\n\n"
    end

    def azkCommand(surCom, direction, tool)
      # Making it easier, some variables used throughtout the method
      cz = self.clonezilla_version
      pool = self.pool.name
      filePath = self.file_location
      netPath = SupportStuff.find_by(name: "imageBasePath").value
      czPath = "#{@@prefix}/CloneZilla/#{cz.name}"

      # Default starting point, that changes depending on tool
      tool == "grub" ? @@azkCom = "#{czPath}/vmlinuz" : @@azkCom = "#{czPath}/initrd.img"
      @@azkCom += " boot=live username=user union=overlay #{surCom.params_set} edd=#{surCom.edd} keyboard-layouts=NONE "

      # Customization based on upload or download.  If true, it will configure for upload, false for download.
      if direction == "upload"
        surCom.prerun0.present?     ? @@azkCom += "ocs_prerun=\"#{surCom.prerun0}\" "             : @@azkCom += "ocs_prerun=\"dhclient -v eth0\" "
        surCom.prerun1.present?     ? @@azkCom += "ocs_prerun1=\"#{surCom.prerun1}\" "            : @@azkCom += "ocs_prerun2=\"sleep 2\" "
        surCom.prerun2.present?     ? @@azkCom += "ocs_prerun2=\"#{surCom.prerun2}\" "            : @@azkCom += "ocs_prerun2=\"sudo mount -t cifs #{netPath} /mnt -o user=sys_iddclonezilla,credentials=/root/.cifs.sys_iddclonezilla,sec=ntlm\" "
        surCom.prerun3.present?     ? @@azkCom += "ocs_prerun3=\"#{surCom.prerun3}\" "            : @@azkCom += "ocs_prerun3=\"sudo mkdir -p /mnt#{filePath}\" "
        surCom.prerun4.present?     ? @@azkCom += "ocs_prerun4=\"#{surCom.prerun4}\" "            : @@azkCom += "ocs_prerun4=\"sudo mount --bind /mnt#{filePath} /home/partimag/\" "
        surCom.live_run.present?    ? @@azkCom += "ocs_live_run=\"#{surCom.live_run}\""           : @@azkCom += "ocs_live_run=\"ocs-sr #{surCom.flags_upload} -scs savedisk ask_user #{self.disk}\" "
        surCom.live_keymap.present? ? @@azkCom += "ocs_live_keymap=\"#{surCom.live_keymap}\""     : @@azkCom += "ocs_live_keymap=\"NONE\""
        surCom.live_param.present?  ? @@azkCom += "ocs_live_param=\"#{surCom.live_param}\""       : nil
        surCom.live_batch.present?  ? @@azkCom += "ocs_live_batch=\"#{surCom.live_batch}\""       : @@azkCom += "ocs_live_batch=\"no\""
        surCom.postrun0.present?    ? @@azkCom += "ocs_postrun=\"#{surCom.postrun0}\""            : nil
        surCom.postrun1.present?    ? @@azkCom += "ocs_postrun1=\"#{surCom.postrun1}\""           : nil
        surCom.postrun2.present?    ? @@azkCom += "ocs_postrun2=\"#{surCom.postrun2}\""           : nil
        surCom.postrun3.present?    ? @@azkCom += "ocs_postrun3=\"#{surCom.postrun3}\""           : nil
        surCom.postrun4.present?    ? @@azkCom += "ocs_postrun4=\"#{surCom.postrun4}\""           : nil
      else
        surCom.prerun0.present?     ? @@azkCom += "ocs_prerun=\"#{surCom.prerun0}\" "             : @@azkCom += "ocs_prerun=\"dhclient -v eth0\" "
        surCom.prerun1.present?     ? @@azkCom += "ocs_prerun1=\"#{surCom.prerun1}\" "            : @@azkCom += "ocs_prerun2=\"sleep 2\" "
        surCom.prerun2.present?     ? @@azkCom += "ocs_prerun2=\"#{surCom.prerun2}\" "            : @@azkCom += "ocs_prerun2=\"sudo mount -t cifs #{netPath}#{filePath} /home/partimag -o user=sys_iddclonezilla,credentials=/root/.cifs.sys_iddclonezilla,sec=ntlm\" "
        surCom.prerun3.present?     ? @@azkCom += "ocs_prerun3=\"#{surCom.prerun3}\" "            : nil
        surCom.prerun4.present?     ? @@azkCom += "ocs_prerun4=\"#{surCom.prerun4}\" "            : nil
        surCom.live_run.present?    ? @@azkCom += "ocs_live_run=\"#{surCom.live_run}\""           : @@azkCom += "ocs_live_run=\"ocs-sr #{surCom.flags_download} -scr restoredisk #{self.name} #{self.disk}\" "
        surCom.live_keymap.present? ? @@azkCom += "ocs_live_keymap=\"#{surCom.live_keymap}\""     : @@azkCom += "ocs_live_keymap=\"NONE\" "
        surCom.live_param.present?  ? @@azkCom += "ocs_live_param=\"#{surCom.live_param}\""       : nil
        surCom.live_batch.present?  ? @@azkCom += "ocs_live_batch=\"#{surCom.live_batch}\""       : @@azkCom += "ocs_live_batch=\"no\" "
        surCom.postrun0.present?    ? @@azkCom += "ocs_postrun=\"#{surCom.postrun0}\""            : nil
        surCom.postrun1.present?    ? @@azkCom += "ocs_postrun1=\"#{surCom.postrun1}\""           : nil
        surCom.postrun2.present?    ? @@azkCom += "ocs_postrun2=\"#{surCom.postrun2}\""           : nil
        surCom.postrun3.present?    ? @@azkCom += "ocs_postrun3=\"#{surCom.postrun3}\""           : nil
        surCom.postrun4.present?    ? @@azkCom += "ocs_postrun4=\"#{surCom.postrun4}\""           : nil
      end
      # More to the command that is same for upload and download.  Changes a little based on tool (Grub/syslinux)
      surCom.locales.present?       ? @@azkCom += "locales=\"#{surCom.locales}\""                 : @@azkCom += "locales=\"en_US.UTF-8\" "
      @@azkCom += "vga=788 net.ifnames=0 toram=filesystem.squashfs live-media-path=#{czPath}"
      tool == "grub" ? @@azkCom += "\n\s\sinitrd #{czPath}/initrd.img" : nil
  end

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

    def grubEntry
      @@menuEntry.print "menuentry \"#{current}#{self.azkName}\" \{\n"
      @@menuEntry.print "\s\slinux #{@@azkCom}\n"
      @@menuEntry.print "\}\n\n"
    end

    def sysEntry
      @@menuEntry.puts "LABEL #{self.azkName}"
      @@menuEntry.puts "\tMENU LABEL #{self.azkName}"
      @@menuEntry.puts "\tKERNEL /live/CloneZilla/#{self.clonezilla_version.name}/vmlinuz"
      @@menuEntry.puts "\tAPPEND initrd=#{@@azkCom}\n\n"
    end

    def createAZKCategoryFiles
        self.try(:category_id).nil? ? category = self : category = Category.find(self.category_id)

        ["upload", "download"].each do |direction|
          ["grub", "syslinux"].each do |tool|
            @@fut.cd("#{@@rootDir}/keygen/live/#{direction}/#{tool}")
            @@menuEntry = File.new("category_#{category.slug}.menu", "w+")

              tool == "grub" ? category.grubDefault : category.sysLinuxDefault

              category.categories.each do |cat|
                tool == "grub" ? cat.grubCatMenuEntry(direction, "category") : cat.sysCatMenuEntry(direction, "category")
              end

              category.present? ? category.breakEntry : nil

              category.systems.each do |sys|
                tool == "grub" ? sys.grubCatMenuEntry(direction, "system") : sys.sysCatMenuEntry(direction, "system")
              end

            @@menuEntry.close

          end
        end
    end

    def createAZKSystemFiles
      self.try(:category_id).nil? ?  system = System.find(self.system_id) : system = System.find(self.id)

      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
          @@fut.cd("#{@@rootDir}/keygen/live/#{direction}/#{tool}")

          @@menuEntry = File.new("system_#{system.slug}.menu", "w+")
            tool == "grub" ? self.grubDefault : self.sysLinuxDefault
            system.images.each do |img|
              if tool == "grub"
                if direction == "upload"
                  img.azkCommand(img.grub_upload, direction, tool)
                else
                  img.azkCommand(img.grub_download, direction, tool)
                end
              else
                if direction == "upload"
                  img.azkCommand(img.syslinux_upload, direction, tool)
                else
                  img.azkCommand(img.syslinux_download, direction, tool)
                end
              end

              tool == "grub" ? img.grubEntry : img.sysEntry
            end

          @@menuEntry.close

        end
      end
    end

    def removeAZK
      FileUtils.ch(@@rootDir)
      FileUtils.rm_r("keygen")
    end

    def createAZKDefault
      FileUtils.cd(@@rootDir)
      Dir.exist?("keygen") ? FileUtils.rm_r("keygen") : nil

      ["boot", "EFI", "home", "live", "syslinux", "utils"].each do |src|
        FileUtils.cp_r("#{@@sourceDir}/#{src}", "keygen")
      end
    end

    def createTopLevel
      #Gathers all of the top level categories
      topLevel = Category.where(is_enabled: 1, category_id: nil)

      # Creating loops to create the 4 files necessary
      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|

          # Changing directory to file path for file
          @@fut.cd("#{@@rootDir}/keygen/live/#{direction}/#{tool}")
          # Starting the file creation
          @@menuEntry = File.new("top.menu", "w+")

          # This line is only added once to the file, it is the default data for the file
          tool == "grub" ? topLevel.grubDefault : topLevel.sysLinuxDefault
          # Loops and adds all top level entries to the file
          topLevel.each do |cat|
            tool == "grub" ? cat.grubCatMenuEntry(direction, "category") : cat.sysCatMenuEntry(direction, "category")
          end

          # Like every door you open, you should close that door.  This is just closing the file.
          @@menuEntry.close
        end
      end
    end

  end # End of Key Module
end # End of the AZK Module