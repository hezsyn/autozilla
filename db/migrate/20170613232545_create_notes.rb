class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text     :information
      t.belongs_to :image, index: true

      t.timestamps
    end
  end
end
