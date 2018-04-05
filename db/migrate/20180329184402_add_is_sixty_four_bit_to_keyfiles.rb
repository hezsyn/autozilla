class AddIsSixtyFourBitToKeyfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :keyfiles, :issixtyfourbit, :string
  end
end
