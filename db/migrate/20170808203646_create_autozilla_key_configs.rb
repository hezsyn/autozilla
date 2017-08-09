class CreateAutozillaKeyConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :autozilla_key_configs do |t|
      t.string        :purpose
      t.string        :kernal
      t.string        :boot
      t.string        :user_name
      t.string        :union
      t.string        :parameters_set1
      t.string        :edd
      t.string        :parameters_set2
      t.string        :keyboardLayout
      t.string        :ocs_prerun0
      t.string        :ocs_prerun1
      t.string        :ocs_prerun2
      t.string        :ocs_prerun3
      t.string        :ocs_prerun4
      t.string        :ocs_live_run
      t.string        :ocs_live_keymap
      t.string        :ocs_live_param
      t.string        :ocs_live_batch
      t.string        :locales
      t.string        :vga
      t.string        :ifname
      t.string        :parameters_set3
      t.string        :fetch
      t.string        :toram
      t.string        :live_media_path

      t.timestamps
    end

  end

end
