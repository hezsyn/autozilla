class CreatePools < ActiveRecord::Migration[5.0]
  def change
    create_table :pools do |t|
      t.string      :name
      t.text        :description
      t.integer     :is_enabled

      t.timestamps
    end
  end
end
