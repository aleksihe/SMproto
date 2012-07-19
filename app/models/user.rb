class User < ActiveRecord::Base
  attr_accessible :esimies, :nimi, :password, :password_confirmation, :tunnus, :salegroup_id
  belongs_to :salegroup
  has_secure_password
 
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :nimi, presence: true
  validates :tunnus, presence: true, length: { minimum: 6 }
    
end
