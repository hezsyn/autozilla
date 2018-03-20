class AddOfficeInstructionsToKeyfile < ActiveRecord::Migration[5.1]
  def change
    add_column :keyfiles, :officeinstructions, :string
  end
end
