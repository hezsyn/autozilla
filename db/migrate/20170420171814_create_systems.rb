class CreateSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
      t.string        :name
      t.string        :slug
      t.text          :description
      t.integer       :is_enabled
      t.string        :file_location
      t.references    :category, foregin_key: true

      t.timestamps
    end
  end
end
