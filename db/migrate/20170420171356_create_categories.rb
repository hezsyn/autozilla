class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string        :name
      t.string        :slug
      t.text          :description
      t.string        :is_enabled
      t.string        :file_location
      t.references    :user, foregin_key: true
      t.references    :category, foregin_key: true

      t.timestamps
    end
  end
end
