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
    def provisio_month
      self.orders.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).sum('provisio')
    end
    def contacts_month
      self.contacts.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
    end
    def sales_month
     self.orders.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).sum('hinta') 
    end
    def pull_today
      if self.contacts_today == 0
        0
      else
        ((self.orders.where('DATE(created_at) = ?', Date.today).count / self.contacts_today.to_f) * 100).to_i
      end    
    end
    def kmprovisio_today
      if self.orders.where('DATE(created_at) = ?', Date.today).count == 0
        0
      else
        self.orders.where('DATE(created_at) = ?', Date.today).average('provisio').round(1)
      end     
    end
    def pull_month
      if self.contacts_month == 0
        0
      else
        ((self.orders.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count / self.contacts_month.to_f) * 100).to_i
      end
    end
    def kmprovisio_month
      if self.orders.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count == 0
        0
      else
        self.orders.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).average('provisio').round(1)
      end      
    end
    def contacts_avg
      date = Date.today
      (self.contacts.where('created_at >= ? and created_at <= ?', Time.zone.now.beginning_of_month, Date.today).count / date.beginning_of_month.business_days_until(date).to_f).round(1)
    end
    def provisio_arvio
      date = Date.today
      self.provisio_month - self.provisio_today + (self.contacts_avg * (self.pull_month/100) * self.kmprovisio_month * (date.business_days_until(date.end_of_month)+1) )
    end
end
