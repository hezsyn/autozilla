class CreateConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :configurations do |t|
      t.string        :name
      t.text          :value
      t.text          :description

      t.timestamps
    end
  end
end
