class Category < ActiveRecord::Base
  attr_accessible :kuvaus
  validates :kuvaus, presence: true
  has_many :products, dependent: :destroy
end
