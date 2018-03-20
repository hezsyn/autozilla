class AddLegalNoticetoKeyfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :keyfiles, :legalnotice, :string
  end
end
