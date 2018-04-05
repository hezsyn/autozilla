class AddWorkOrderToQa < ActiveRecord::Migration[5.1]
  def change
    add_column :qas, :workorder, :string
  end
end
