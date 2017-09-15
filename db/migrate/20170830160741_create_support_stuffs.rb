class CreateSupportStuffs < ActiveRecord::Migration[5.1]
  def change
    create_table :support_stuffs do |t|
      t.string      :name
      t.text        :value
      t.text        :description

      t.timestamps
    end
  end
end
