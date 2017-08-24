class System < ApplicationRecord
  has_many :images

  def makeEntry
    prefix = "/mnt/c/Users/hezsy/Development/KeyGen/live"
    grubLoc = prefix + "/grub"
    sysLoc = prefix + "/syslinux"

    @category = Category.find(category_id)

    #Defaults for the file structure
    keyPrefix = "/live"
    default   = "0"
    confFile  = "/EFI/boot/graphics.cfg"


    [grubLoc, sysLoc].each do |loc|
      File.directory?(loc) ? "moo" : Dir.mkdir(loc)
      Dir.chdir(loc)

      menuEntry = File.new("system_#{@category.slug}.menu", "w+")
      menuEntry.puts("set default=#{default}")
      menuEntry.puts("configFile /EFI/boot/graphics.cfg")
      menuEntry.puts("")
      menuEntry.puts("menuentry \"#{name}\" \{")
      menuEntry.print("linux #{prefix}/CloneZilla/#{clonezilla_version.name}/vmlinuz ")
      menuEntry.print("boot=#{clonezilla_version.boot} ")
      menuEntry.print("#{clonezilla_version.parameters_set1} ")
      menuEntry.print("edd=#{clonezilla_version.edd} ")
      menuEntry.print("#{clonezilla_version.parameters_set2} ")
      menuEntry.print("ocs_prerun0=#{clonezilla_version.ocs_prerun0} ")
      menuEntry.print("ocs_prerun1=#{clonezilla_version.ocs_prerun1} ")
      menuEntry.print("ocs_prerun2=#{clonezilla_version.ocs_prerun2} ")
      menuEntry.print("ocs_live_run=#{clonezilla_version.ocs_live_run} ")
      menuEntry.print("ocs_live_param=#{clonezilla_version.ocs_live_param} ")
      menuEntry.print("ocs_live_keymap=#{clonezilla_version.ocs_live_keymap} ")
      menuEntry.print("ocs_live_keymap=#{clonezilla_version.} ")


      menuEntry.close
    end
  end

end
