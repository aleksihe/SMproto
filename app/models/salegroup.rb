class Salegroup < ActiveRecord::Base
  has_many :users, :dependent => :nullify
  has_many :contacts
  has_many :goals
  has_one :category
  attr_accessible :nimi, :category_id
  validates :nimi, presence: true, :uniqueness => true
  validates :category_id, presence: true
end
