class Category < ApplicationRecord
  has_many :categories
  has_many :systems

  validates :name, presence: true

  def makeMenuEntry
      prefix  = "/mnt/c/Users/hezsy/Development/KeyGen/live"
      grubLoc = prefix + "/grub"
      sysLoc  = prefix + "/syslinux"

      @topCategory = Category.find(category_id)
      #Defaults for the file structure
      keyPrefix = "/live"
      default   = "0"
      confFile  = "/EFI/boot/graphics.cfg"

    if category_id == nil
      [grubLoc, sysLoc].each do |cat|
        File.directory?(cat) ? "moo" : Dir.mkdir(cat)
        Dir.chdir(cat)

        menuEntry = File.new("top_level.menu", "w")
        menuEntry.puts("set default=#{default}")
        menuEntry.puts("configFile #{confFile}")
        menuEntry.puts("")

        Category.where(category_id: NIL, is_enabled: 1).order(:name).each do |topCat|
          menuEntry.puts("menuentry \"#{topCat.name}\" \{")
          menuEntry.puts("\tconfigFile #{keyPrefix}/download/#{cat}/category_#{topCat.slug}.menu")
          menuEntry.puts("\}")
          menuEntry.puts("")
        end

        menuEntry.close
      end

    else
      [grubLoc, sysLoc].each do |subcat|
        File.directory?(subcat) ? "moo" : Dir.mkdir(subcat)
        Dir.chdir(subcat)

        menuEntry = File.new("category_#{@topCategory.slug}.menu", "w")
        menuEntry.puts("set default=#{default}")
        menuEntry.puts("configFile #{confFile}")
        menuEntry.puts("")

        menuEntry.puts("menuentry \"#{name}\" \{")
        subcat == sysLoc ? menuEntry.puts("\tconfigFile #{keyPrefix}/download/syslinux/category_#{slug}.menu") : menuEntry.puts("\tconfigFile #{keyPrefix}/download/grub/category_#{slug}.menu")
        menuEntry.puts("\}")
        menuEntry.puts("")

        Category.where(category_id: category_id, is_enabled: 1).order(:name).each do |topCat|
          menuEntry.puts("menuentry \"#{topCat.name}\" \{")
          subcat == sysLoc ? menuEntry.puts("\tconfigFile #{keyPrefix}/download/syslinux/category_#{topCat.slug}.menu") : menuEntry.puts("\tconfigFile #{keyPrefix}/download/grub/category_#{topCat.slug}.menu")
          menuEntry.puts("\}")
          menuEntry.puts("")
        end

        menuEntry.close
      end

    end
  end

end
