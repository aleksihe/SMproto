class Product < ActiveRecord::Base
  attr_accessible :category_id, :hinta, :kuvaus, :provisio
  
  belongs_to :category
end
