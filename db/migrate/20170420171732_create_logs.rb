class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string      :name
      t.references  :user, foregin_key: true
      t.string      :ip_address
      t.string      :action

      t.timestamps
    end
  end
end
