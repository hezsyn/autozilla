module Azk
  module Support
    require 'fileutils'

    def setSettings
      @@fut = FileUtils
      @@rootDir = SupportStuff.find_by(name: "rootKeyDir").value
      @@sourceDir = @@rootDir + "/" + SupportStuff.find_by(name: "sourceKey").value
      @@prodKey = @@rootDir + "/" + SupportStuff.find_by(name: "productionKey").value
      @@czSource = @@rootDir + "/" + SupportStuff.find_by(name: "czSource").value
      @@czProduction = @@rootDir + "/" + SupportStuff.find_by(name: "czProduction").value

      @@default = "\"0\""
      @@prefix = "/live"
    end

    def breakEntry
      "*=======================================================================*\n\n"
    end

    def grubDefault(direction)
      @defaultLoader = "set default=#{@@default}\n"
      if direction == "download"
        @defaultLoader += "configfile /EFI/boot/graphics.cfg\n\n"
      else
        @defaultLoader += "configfile /EFI/boot/graphics_upload.cfg\n\n"
      end
    end

    def sysLinuxDefault(direction)
      if direction == "download"
        defaultLoader = "INCLUDE /EFI/boot/graphics.cfg\n\n"
      else
        defaultLoader = "INCLUDE /EFI/boot/graphics_upload.cfg\n\n"
      end
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


  end
end