module Azk
  module System
    extend Azk::Support

    def grubEntry
      @@menuEntry.print "menuentry \"#{self.name}\" \{\n"
      @@menuEntry.print "\s\slinux #{@@azkCom}\n"
      @@menuEntry.print "\}\n\n"
    end

    def sysEntry
      @@menuEntry.puts "LABEL #{self.name}"
      @@menuEntry.puts "\tMENU LABEL #{self.name}"
      @@menuEntry.puts "\tKERNEL /live/CloneZilla/#{self.clonezilla_version.name}/vmlinuz"
      @@menuEntry.puts "\tAPPEND initrd=#{@@azkCom}\n\n"
    end

    def createAZKSystemFiles
      setSettings
      self.try(:category_id).nil? ? system = System.find(self.system_id) : system = System.find_by(name: self.name)

      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
          @@fut.cd("#{@@prodKey}/live/#{direction}/#{tool}")

          @@menuEntry = File.new("system_#{system.slug}.menu", "w+")
            tool == "grub" ? self.grubDefault(direction) : self.sysLinuxDefault(direction)
            system.images.order(:name).where(:is_enabled == 1).each do |img|
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

  end
end
