#coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :esimies, :nimi, :password, :password_confirmation, :tunnus, :salegroup_id
  belongs_to :salegroup
  has_many :contacts
  has_many :orders
  has_many :goals
  has_and_belongs_to_many :competitions
  has_secure_password
 
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :nimi, presence: true
  validates :tunnus, presence: true, length: { minimum: 6 }, :uniqueness => true
    
       
    #first = date beginning, last = date end
    def contacts_count(first, last)
      if last.nil?
        self.contacts.where('DATE(created_at) = ?', first).count
      else
        self.contacts.where('created_at >= ? and created_at <= ?', first, last).count
      end  
    end
    
    def sales_sum(first, last)
      if last.nil?
        self.orders.where('DATE(created_at) = ?', first).sum('hinta') 
      else
        self.orders.where('created_at >= ? and created_at <= ?', first, last).sum('hinta')
      end    
    end
    
    def provisio_sum(first, last)
      if last.nil?
        self.orders.where('DATE(created_at) = ?', first).sum('provisio')
      else
        self.orders.where('created_at >= ? and created_at <= ?', first, last).sum('provisio')
      end    
    end
    
    def pull(first, last)
      if last.nil?
        if self.contacts_count(first, nil) == 0
          0
        else
          ((self.orders.where('DATE(created_at) = ?', first).count / self.contacts_count(first, nil).to_f) * 100).to_i
        end
      else
        if self.contacts_count(first, last) == 0
          0
        else
          ((self.orders.where('created_at >= ? and created_at <= ?', first, last).count / self.contacts_count(first, last).to_f) * 100).to_i
        end
      end        
    end
    
    def kmprovisio(first, last)
      if last.nil?
        if self.orders.where('DATE(created_at) = ?', first).count == 0
          0
        else
          self.orders.where('DATE(created_at) = ?', first).average('provisio').to_f.round(1)
        end 
      else
        if self.orders.where('created_at >= ? and created_at <= ?', first, last).count == 0
          0
        else
          self.orders.where('created_at >= ? and created_at <= ?', first, last).average('provisio').to_f.round(1)
        end
      end        
    end 
    
    def kmmyynti(first,last)
      if last.nil?
        if self.orders.where('DATE(created_at) = ?', first).count == 0
          0
        else
          self.orders.where('DATE(created_at) = ?', first).average('hinta').to_f.round(1)
        end 
      else
        if self.orders.where('created_at >= ? and created_at <= ?', first, last).count == 0
          0
        else
          self.orders.where('created_at >= ? and created_at <= ?', first, last).average('hinta').to_f.round(1)
        end
      end       
    end
      
    def contacts_avg(first, last)
      last = last + 1
      if self.contacts.any?
        if first < self.contacts.first.created_at.to_date
          first = self.contacts.first.created_at.to_date
        end
      end   
      (self.contacts.where('created_at >= ? and created_at <= ?', first, last).count / first.business_days_until(Date.today+1).to_f).round(1)
    end
    
    def provisio_arvio(first, last)    
      date = Date.today + 1
      self.provisio_sum(first, last) + (self.contacts_avg(first, date) * (self.pull(first, date)/100.0) * self.kmprovisio(first, date) * date.business_days_until(last) )
    end
    
    def myynti_arvio(first, last)     
      date = Date.today + 1
      self.sales_sum(first, last) + (self.contacts_avg(first, date) * (self.pull(first, date)/100.0) * self.kmmyynti(first, date) * date.business_days_until(last) )
    end
    
    def contacts_arvio(first, last)    
      date = Date.today + 1
      self.contacts_count(first, last) + (self.contacts_avg(first, date) * date.business_days_until(last) )
    end
    
    def kkbonus_arvio(first, last, kriteeri)
      last = last + 1
      date = Date.today + 1
      bonus = 0
      bonustasot = self.salegroup.bonuslevels.where("laji = ? and kriteeri = ?", "kkbonus", kriteeri)
      if kriteeri == "myynti(e)"
        myynti = self.sales_sum(first, last) + (self.contacts_avg(first, date) * (self.pull(first, date)/100.0) * self.kmmyynti(first, date) * date.business_days_until(last) )
        bonustasot.each do |b|
          if b.ehto <= myynti
            bonus = bonus + b.bonus_maara
          end
        end       
      end
      return bonus
    end
    
    def orders_count(first,last)
       self.orders.where('created_at >= ? and created_at <= ?', first, last).count
    end
    
    #tavoitelaskelmat
    def tavoite(first,last,tyyppi)
      goal = self.goals.where('alku < ? and loppu > ? and tyyppi = ?', DateTime.now, DateTime.now, tyyppi)
      if goal.empty?
        return 0
      else
        goal_alku = Date.new(goal.first.alku.year, goal.first.alku.month, goal.first.alku.day)
        goal_loppu = Date.new(goal.first.loppu.year, goal.first.loppu.month, goal.first.loppu.day)+ 1.day
        first = Date.new(first.year, first.month, first.day)
        last = Date.new(last.year, last.month, last.day)+ 1.day 
        return ((goal.first.maara / goal_alku.business_days_until(goal_loppu)) * first.business_days_until(last)).round(1)
      end
      
    end
end
