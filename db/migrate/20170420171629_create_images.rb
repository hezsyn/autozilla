class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string      :name
      t.text        :note
      t.text        :description
      t.string      :disk
      t.string      :flags
      t.string      :flags_upload
      t.string      :path
      t.string      :loader_string
      t.references  :user, foregin_key: true
      t.references  :system, foregin_key: true
      t.references  :pool, foregin_key: true
      t.references  :ose, foregin_key: true
      t.references  :image_status, foregin_key: true
      t.references  :clonezilla_version, foregin_key: true
      t.string      :autoboot

      t.timestamps
    end
  end
end
