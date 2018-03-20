class AddKeyfileTypeToKeyfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :keyfiles, :keyfile_type, :string
  end
end
