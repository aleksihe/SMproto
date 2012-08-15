class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :salegroup
  has_many :orders
  attr_accessible :tilaus, :user_id, :created_at, :updated_at, :salegroup_id
 
  validates :user_id, presence: true 
  
end
