class AddOfficeInstructionsToQa < ActiveRecord::Migration[5.1]
  def change
    add_column :qas, :officeinstructions, :string
  end
end
