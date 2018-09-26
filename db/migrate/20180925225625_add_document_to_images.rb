class AddDocumentToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :document, :string
  end
end
