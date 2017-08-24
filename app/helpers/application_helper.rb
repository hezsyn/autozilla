module ApplicationHelper

  def is_enabled?(status)
    status == 1 ? "Enabled" : "Disabled"
  end

  def grubFiles

      # Top Level / Category
        menuEntry.puts("set default=#{default}")
        menuEntry.puts("configFile #{confFile}")
        menuEntry.puts("")

        Category.where(category_id: NIL, is_enabled: 1).order(:name).each do |topCat|
          menuEntry.puts("menuentry \"#{topCat.name}\" \{")
          menuEntry.puts("\tconfigFile #{keyPrefix}/download/#{cat}/category_#{topCat.slug}.menu")
          menuEntry.puts("\}")
          menuEntry.puts("")
        end


      # System


      #Image File
      menuEntry = File.new("system_#{System.find(system_id).slug}.menu", "w+")
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
  end

  def syslinuxFiles

  end

end
