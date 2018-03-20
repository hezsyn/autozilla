class AddLegalNoticeToQa < ActiveRecord::Migration[5.1]
  def change
    add_column :qas, :legalnotice, :string
  end
end
