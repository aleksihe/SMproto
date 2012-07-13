class Category < ActiveRecord::Base
  attr_accessible :kuvaus
  has_many :products
end
