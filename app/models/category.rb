class Category < ActiveRecord::Base
  attr_accessible :kuvaus, :salegroup_id
  validates :kuvaus, presence: true, :uniqueness => true
  has_many :products, dependent: :destroy
  belongs_to :salegroup
end
