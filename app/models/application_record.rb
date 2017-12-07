class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def objectLocation
    x = self
    # Setting / Resetting fileArray for creating file path
    @fileArray = Array.new

    # Image Path, checks if it is an image
      if x.try(:system_id).present?
        @fileArray.push(x.name)
        x = System.find(x.system_id)
      end

    # Setting category file path
    if x.category_id.nil?
      @fileLocation = x.name
    else
      # Checks if category_id is present, loops through til it gets to the top level category
      while x.category_id.present?
        @fileArray.push(x.name)
        x = Category.find(x.category_id)
      end
      # Spills out the array to create the fileLocation path
      @fileArray.push(x.name)
      @fileArray.reverse.each do |coo|
        @fileLocation = "#{@fileLocation}/#{coo}"
      end
    end
    @fileLocation.gsub(" ","_")
  end

  def makeSlug
    # removes the first and last white spaces
    slug.strip
    # Replaces any spaces to _
    slug.gsub!(" ", "_")
    # Sets all the characters to lowercase
    slug.downcase!
    c = System.where(name: name).count
    c += Category.where(name: name).count
    c += 1
    slug << "#{c}"
  end

  def self.search(search)
    where("name ILIKE ?", "%#{search}")
  end

end
