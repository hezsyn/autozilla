class AddBiosToKeyfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :keyfiles, :bios, :string
  end
end
