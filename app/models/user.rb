class User < ActiveRecord::Base
  attr_accessible :esimies, :nimi, :password, :password_confirmation, :tunnus, :salegroup_id
  belongs_to :salegroup
  has_many :contacts
  has_many :orders
  has_secure_password
 
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :nimi, presence: true
  validates :tunnus, presence: true, length: { minimum: 6 }
    
    def contacts_today
      self.contacts.where('DATE(created_at) = ?', Date.today).count
    end
    def sales_today
     self.orders.where('DATE(created_at) = ?', Date.today).sum('hinta') 
    end
    def provisio_today
      self.orders.where('DATE(created_at) = ?', Date.today).sum('provisio')
    end
    def provisio_palkkakausi
      self.orders.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).sum('provisio')
    end
end
