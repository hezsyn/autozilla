class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string        :whatSearch
      t.references    :user, foregin_key: true

      t.timestamps
    end
  end
end
