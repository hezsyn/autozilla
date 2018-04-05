class AddIsSixtyFourBitToQa < ActiveRecord::Migration[5.1]
  def change
    add_column :qas, :issixtyfourbit, :string
  end
end
