class Salegroup < ActiveRecord::Base
  has_many :users
  attr_accessible :nimi
end
