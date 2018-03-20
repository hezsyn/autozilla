class AddKeyFileIdToQa < ActiveRecord::Migration[5.1]
  def change
    add_column :qas, :keyfileid, :string
  end
end
