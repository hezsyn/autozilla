class CreateAutozillaKeyConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :autozilla_key_configs do |t|
      t.string        :purpose
      t.string        :params_set
      t.string        :edd
      t.string        :prerun0
      t.string        :prerun1
      t.string        :prerun2
      t.string        :prerun3
      t.string        :prerun4
      t.string        :live_run
      t.string        :live_keymap
      t.string        :live_param
      t.string        :live_batch
      t.string        :repository
      t.string        :postrun0
      t.string        :postrun1
      t.string        :postrun2
      t.string        :postrun3
      t.string        :postrun4
      t.string        :locales
      t.string        :flags
      t.string        :loader_string
      t.string        :location

      t.timestamps
    end

  end

end
