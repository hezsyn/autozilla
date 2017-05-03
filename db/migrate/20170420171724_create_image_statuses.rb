class CreateImageStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :image_statuses do |t|
      t.string        :name
      t.integer       :is_visible

      t.timestamps
    end
  end
end
