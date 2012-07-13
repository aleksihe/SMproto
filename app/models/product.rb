class Product < ActiveRecord::Base
  attr_accessible :category_id, :hinta, :kuvaus, :provisio
  validates :category_id, presence: true
  validates :hinta, presence: true
  validates :kuvaus, presence: true
  validates :provisio, presence: true
  validates_numericality_of :hinta, :on => :create
  validates_numericality_of :provisio, :on => :create
  belongs_to :category
end
