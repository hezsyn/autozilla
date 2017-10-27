class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string        :name
      t.string        :username
      t.integer       :is_domain_login
      t.string        :slug
      t.string        :password
      t.string        :email
      t.date          :last_login
      t.string        :role
      t.integer       :active

      t.timestamps
    end
  end
end
