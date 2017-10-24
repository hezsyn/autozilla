module Azk
  module Key
    require 'fileutils'

    def setSettings
      @@fut = FileUtils
      @@rootDir = SupportStuff.find_by(name: "rootKeyDir").value
      @@sourceDir = SupportStuff.find_by(name: "sourceKey").value
      @@prodKey = SupportStuff.find_by(name: "productionKey").value

      @@default = "\"0\""
      @@prefix = "/live"
    end

    def breakEntry
      @@menuEntry.puts "*=======================================================================*\n\n"
    end

    def grubDefault
      @@menuEntry.puts "set default=#{@@default}"
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
      netPath = surCom.location
      czPath = "#{@@prefix}/CloneZilla/#{cz.name}"

      # Default starting point, that changes depending on tool
      tool == "grub" ? @@azkCom = "#{czPath}/vmlinuz " : @@azkCom = "#{czPath}/initrd.img "
      @@azkCom.concat("boot=live username=user union=overlay ")
      @@azkCom.concat(surCom.params_set.present? ? "#{surCom.params_set} "     : "#{cz.params_set} ")
      @@azkCom.concat("edd=", surCom.edd.present? ? "#{surCom.edd} "             : "#{cz.edd} ")
      @@azkCom.concat("keyboard-layouts=NONE ")
      if direction == "grub"
        surCom.prerun0.present? ?       @@azkCom +=  "ocs_prerun=\"#{surCom.prerun0}\" "            : @@azkCom += "ocs_prerun=\"#{cz.upload.prerun0}\" "
        surCom.prerun1.present? ?       @@azkCom +=  "ocs_prerun1=\"#{surCom.prerun1}\" "           : @@azkCom += "ocs_prerun1=\"#{cz.upload.prerun1}\" "
        surCom.prerun2.present? ?       @@azkCom +=  "ocs_prerun2=\"#{surCom.prerun2}\" "           : @@azkCom += "ocs_prerun2=\"#{cz.upload.prerun2}\" "
        surCom.prerun3.present? ?       @@azkCom +=  "ocs_prerun3=\"#{surCom.prerun3}\" "           : @@azkCom += "ocs_prerun3=\"#{cz.upload.prerun3}\" "
        surCom.prerun4.present? ?       @@azkCom +=  "ocs_prerun4=\"#{surCom.prerun4}\" "           : @@azkCom += "ocs_prerun4=\"#{cz.upload.prerun4}\" "
        surCom.live_run.present? ?      @@azkCom +=  "ocs_live_run=\"#{surCom.live_run}\" "         : @@azkCom += "ocs_live_run=\"#{cz.upload.live_run}\" "
        surCom.live_keymap.present? ?   @@azkCom +=  "ocs_live_keymap=\"#{surCom.live_keymap}\" "   : @@azkCom += "ocs_live_keymap=\"#{cz.upload.live_keymap}\" "
        surCom.live_param.present? ?    @@azkCom +=  "ocs_live_param=\"#{surCom.live_param}\" "     : @@azkCom += "ocs_live_param=\"#{cz.upload.live_param}\" "
        surCom.live_batch.present? ?    @@azkCom +=  "ocs_live_batch=\"#{surCom.live_batch}\" "     : @@azkCom += "ocs_live_batch=\"#{cz.upload.live_batch}\" "
        surCom.postrun0.present? ?      @@azkCom +=  "ocs_postrun=\"#{surCom.postrun0}\" "          : @@azkCom += "ocs_postrun0=\"#{cz.upload.postrun0}\" "
        surCom.postrun1.present? ?      @@azkCom +=  "ocs_postrun1=\"#{surCom.postrun1}\" "         : @@azkCom += "ocs_postrun1=\"#{cz.upload.postrun1}\" "
        surCom.postrun2.present? ?      @@azkCom +=  "ocs_postrun2=\"#{surCom.postrun2}\" "         : @@azkCom += "ocs_postrun2=\"#{cz.upload.postrun2}\" "
        surCom.postrun3.present? ?      @@azkCom +=  "ocs_postrun3=\"#{surCom.postrun3}\" "         : @@azkCom += "ocs_postrun3=\"#{cz.upload.postrun3}\" "
        surCom.postrun4.present? ?      @@azkCom +=  "ocs_postrun4=\"#{surCom.postrun4}\" "         : @@azkCom += "ocs_postrun4=\"#{cz.upload.postrun4}\" "
        surCom.locales.present? ?       @@azkCom +=  "locales=\"#{surCom.locales}\" "               : "locales=\"#{cz.upload.locales}\" "
      else
        surCom.prerun0.present? ?       @@azkCom +=  "ocs_prerun=\"#{surCom.prerun0}\" "            : @@azkCom += "ocs_prerun=\"#{cz.download.prerun0}\" "
        surCom.prerun1.present? ?       @@azkCom +=  "ocs_prerun1=\"#{surCom.prerun1}\" "           : @@azkCom += "ocs_prerun1=\"#{cz.download.prerun1}\" "
        surCom.prerun2.present? ?       @@azkCom +=  "ocs_prerun2=\"#{surCom.prerun2}\" "           : @@azkCom += "ocs_prerun2=\"#{cz.download.prerun2}\" "
        surCom.prerun3.present? ?       @@azkCom +=  "ocs_prerun3=\"#{surCom.prerun3}\" "           : @@azkCom += "ocs_prerun3=\"#{cz.download.prerun3}\" "
        surCom.prerun4.present? ?       @@azkCom +=  "ocs_prerun4=\"#{surCom.prerun4}\" "           : @@azkCom += "ocs_prerun4=\"#{cz.download.prerun4}\" "
        surCom.live_run.present? ?      @@azkCom +=  "ocs_live_run=\"#{surCom.live_run}\" "         : @@azkCom += "ocs_live_run=\"#{cz.download.live_run}\" "
        surCom.live_keymap.present? ?   @@azkCom +=  "ocs_live_keymap=\"#{surCom.live_keymap}\" "   : @@azkCom += "ocs_live_keymap=\"#{cz.download.live_keymap}\" "
        surCom.live_param.present? ?    @@azkCom +=  "ocs_live_param=\"#{surCom.live_param}\" "     : @@azkCom += "ocs_live_param=\"#{cz.download.live_param}\" "
        surCom.live_batch.present? ?    @@azkCom +=  "ocs_live_batch=\"#{surCom.live_batch}\" "     : @@azkCom += "ocs_live_batch=\"#{cz.download.live_batch}\" "
        surCom.postrun0.present? ?      @@azkCom +=  "ocs_postrun=\"#{surCom.postrun0}\" "          : @@azkCom += "ocs_postrun=\"#{cz.download.postrun0}\" "
        surCom.postrun1.present? ?      @@azkCom +=  "ocs_postrun1=\"#{surCom.postrun1}\" "         : @@azkCom += "ocs_postrun1=\"#{cz.download.postrun1}\" "
        surCom.postrun2.present? ?      @@azkCom +=  "ocs_postrun2=\"#{surCom.postrun2}\" "         : @@azkCom += "ocs_postrun2=\"#{cz.download.postrun2}\" "
        surCom.postrun3.present? ?      @@azkCom +=  "ocs_postrun3=\"#{surCom.postrun3}\" "         : @@azkCom += "ocs_postrun3=\"#{cz.download.postrun3}\" "
        surCom.postrun4.present? ?      @@azkCom +=  "ocs_postrun4=\"#{surCom.postrun4}\" "         : @@azkCom += "ocs_postrun4=\"#{cz.download.postrun4}\" "
        surCom.locales.present? ?       @@azkCom +=  "locales=\"#{surCom.locales}\" "               : "locales=\"#{cz.download.locales}\" "
      end
      @@azkCom.concat("vga=788 net.ifnames=0 toram=filesystem.squashfs live-media-path=#{czPath} ")
      tool == "grub" ? @@azkCom += "\n\s\sinitrd #{czPath}/initrd.img" : nil
      @@azkCom = eval '"' + @@azkCom.gsub('"', '\"') + '"'
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
      setSettings

        ["upload", "download"].each do |direction|
          ["grub", "syslinux"].each do |tool|
            @@fut.cd("#{@@rootDir}/#{@@prodKey}/live/#{direction}/#{tool}")
            @@menuEntry = File.new("category_#{self.slug}.menu", "w+")

              tool == "grub" ? self.grubDefault : self.sysLinuxDefault

              puts self.file_location

              self.categories.each do |cat|
                tool == "grub" ? cat.grubCatMenuEntry(direction, "category") : cat.sysCatMenuEntry(direction, "category")
              end

              self.breakEntry if self.systems.present?

              self.systems.each do |sys|
                tool == "grub" ? sys.grubCatMenuEntry(direction, "system") : sys.sysCatMenuEntry(direction, "system")
              end

            @@menuEntry.close

          end
        end
    end

    def createAZKSystemFiles
      setSettings
      system = System.find(self.system_id) if self.system_id != nil

      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
          @@fut.cd("#{@@rootDir}/#{@@prodKey}/live/#{direction}/#{tool}")

          @@menuEntry = File.new("system_#{system.slug}.menu", "w+")
            tool == "grub" ? self.grubDefault : self.sysLinuxDefault
            system.images.each do |img|
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

              tool == "grub" ? img.grubEntry : img.sysEntry
            end

          @@menuEntry.close

        end
      end
    end

    def removeAZK
      setSettings
      FileUtils.ch(@@rootDir)
      FileUtils.rm_r("production")
    end

    def createAZKDefault
      setSettings
      FileUtils.cd(@@rootDir)
      Dir.exist?("production") ? FileUtils.rm_r("production") : nil

      ["boot", "EFI", "home", "live", "syslinux", "utils"].each do |src|
        FileUtils.cp_r("#{@@sourceDir}/#{src}", "keygen")
      end
    end

    def createTopLevel
      setSettings
      if File.exist?("#{@@rootDir}#{@@prodKey}/live/download/grub/top.menu")
        nil
      else
      #Gathers all of the top level categories
      topLevel = Category.where(is_enabled: 1, category_id: nil)

      # Creating loops to create the 4 files necessary
      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|

          # Changing directory to file path for file
          @@fut.cd("#{@@rootDir}/#{@@prodKey}/live/#{direction}/#{tool}")
          # Starting the file creation
          @@menuEntry = File.new("top.menu", "w+")

          # This line is only added once to the file, it is the default data for the file
          tool == "grub" ? grubDefault : sysLinuxDefault
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

  def removeEntry(entryType, entity)
    setSettings
    ["upload", "download"].each do |direction|
      ["grub", "syslinux"].each do |tool|
          # Changing directory to file path for file
          @@fut.cd("#{@@rootDir}/#{@@prodKey}/live/#{direction}/#{tool}")
          @@fut.rm("#{entryType}_#{entity.slug}.menu") if File.exist?("#{entryType}_#{entity.slug}.menu")
      end
    end
  end

  end # End of Key Module
end # End of the AZK Module