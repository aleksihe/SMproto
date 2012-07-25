class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  attr_accessible :tilaus, :user_id
 
  validates :user_id, presence: true 
end
