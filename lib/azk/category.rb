module Azk
  module Category
    include Azk::Support

    def grubCatMenuEntry(direction, entryType)
      @defaultLoader += "menuentry \"#{self.name}\" \{"
      @defaultLoader += "\n\tconfigfile #{@@prefix}/#{direction}/grub/#{entryType}_#{self.slug}.menu\n"
      @defaultLoader += "\}\n\n"
    end

    def sysCatMenuEntry(direction, entryType)
      @defaultLoader += "LABEL #{self.name}"
      @defaultLoader += "MENU LABEL #{self.name}"
      @defaultLoader += "KERNAL vesamenu.c32"
      @defaultLoader += "APPEND #{@@prefix}/#{direction}/syslinux/#{entryType}_#{self.slug}.menu\n\n"
    end

    def createAZKCategoryFiles
      setSettings

      ["upload", "download"].each do |direction|
        ["grub", "syslinux"].each do |tool|
          @@fut.cd("#{@@prodKey}/live/#{direction}/#{tool}")
          @@menuEntry = File.new("category_#{self.slug}.menu", "w+")

            tool == "grub" ? self.grubDefault(direction) : self.sysLinuxDefault(direction)

            puts self.file_location

            self.categories.order(:name).where(:is_enabled == 1).each do |cat|
              tool == "grub" ? cat.grubCatMenuEntry(direction, "category") : cat.sysCatMenuEntry(direction, "category")
            end

            self.breakEntry if self.systems.present?

            self.systems.order(:name).where(:is_enabled == 1).each do |sys|
              tool == "grub" ? sys.grubCatMenuEntry(direction, "system") : sys.sysCatMenuEntry(direction, "system")
            end

          @@menuEntry.close

        end
      end
    end

    def createTopLevel
      setSettings
      if File.exist?("#{@@prodKey}/live/download/grub/top.menu")
        nil
      else
        # Creating loops to create the 4 files necessary
        ["upload", "download"].each do |direction|
          ["grub", "syslinux"].each do |tool|

            # Changing directory to file path for file
            @@fut.cd("#{@@prodKey}/live/#{direction}/#{tool}")
            # Starting the file creation
            @menuEntry = File.new("top.menu", "w+")

            # This line is only added once to the file, it is the default data for the file
            tool == "grub" ? grubDefault(direction) : sysLinuxDefault(direction)
            # Loops and adds all top level entries to the file

            tool == "grub" ? self.grubCatMenuEntry(direction, "category") : self.sysCatMenuEntry(direction, "category")

            @menuEntry.puts @defaultLoader
            # Like every door you open, you should close that door.  This is just closing the file.
            @menuEntry.close
          end
        end
      end
    end

  end
end
