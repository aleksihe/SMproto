class Order < ActiveRecord::Base
  belongs_to :contact
  belongs_to :user
  attr_accessible :contact_id, :hinta, :kuvaus, :provisio, :user_id, :created_at, :updated_at 
  validates :contact_id, presence: true
  validates :user_id, presence: true
  validates :hinta, presence: true
  validates :kuvaus, presence: true
  validates :provisio, presence: true
end
