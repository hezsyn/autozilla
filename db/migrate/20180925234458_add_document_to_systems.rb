class AddDocumentToSystems < ActiveRecord::Migration[5.2]
  def change
    add_column :systems, :document, :string
  end
end
