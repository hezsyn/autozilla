class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string      :name
      t.text        :description
      t.string      :disk
      t.string      :flags
      t.string      :flags_upload
      t.string      :path
      t.string      :loader_string
      t.string      :file_location
      t.belongs_to  :note, index: true
      t.belongs_to  :user, index: true
      t.belongs_to  :system, index: true
      t.belongs_to  :pool, index: true
      t.belongs_to  :ose, index: true
      t.belongs_to  :image_status, index: true
      t.belongs_to  :clonezilla_version, index: true
      t.string      :autoboot

      t.timestamps
    end
  end
end

