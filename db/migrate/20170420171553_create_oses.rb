class CreateOses < ActiveRecord::Migration[5.0]
  def change
    create_table :oses do |t|
      t.string      :name
      t.integer     :is_enabled

      t.timestamps
    end
  end
end
