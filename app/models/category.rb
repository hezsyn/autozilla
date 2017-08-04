class Category < ApplicationRecord
  has_many :categories
  has_many :systems

  validates :name, presence: true

  def fileLocation
    filePrefix = 'C:\Users\hezsy\Desktop\Output\\'
    fileLocation = filePrefix

    loop do
      if self.category_id.nil?
        fileLocation << self.name
        break
      else
        fileLocation << Category.find(self.category_id).name + '\\'
      end
    end
  end

end
