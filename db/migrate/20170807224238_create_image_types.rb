class CreateImageTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :image_types do |t|
      t.string  :name
      t.string  :description
      t.integer :is_enabled

      t.timestamps
    end
  end
end
