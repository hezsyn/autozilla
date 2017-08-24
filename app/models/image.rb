class Image < ApplicationRecord
  has_many   :notes
  belongs_to :pool
  belongs_to :system
  belongs_to :ose
  belongs_to :image_status
  belongs_to :clonezilla_version
  belongs_to :image_type
  belongs_to :grub_upload, class_name: "AutozillaKeyConfig"
  belongs_to :grub_download, class_name: "AutozillaKeyConfig"
  belongs_to :syslinux_upload, class_name: "AutozillaKeyConfig"
  belongs_to :syslinux_download, class_name: "AutozillaKeyConfig"

  def azkName
    pool.name + " - " + image_type.name + " - " + ose.name + " - bheinrix - " + updated_at.strftime("%m%b%Y")
  end

  def makeEntry
    prefix = "/mnt/c/Users/hezsy/Development/KeyGen"
    grubLoc = prefix + "/grub"
    sysLoc = prefix + "/syslinux"

    [grubLoc, sysLoc].each do |loc|
      File.directory?(loc) ? "moo" : Dir.mkdir(loc)
      Dir.chdir(loc)

      menuEntry = File.new("system_#{System.find(system_id).slug}.menu", "w+")
      menuEntry.close
    end
  end

end
