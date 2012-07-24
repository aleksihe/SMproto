class Order < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :contact_id, :hinta, :kuvaus, :provisio
  validates :contact_id, presence: true
  validates :hinta, presence: true
  validates :kuvaus, presence: true
  validates :provisio, presence: true
end
