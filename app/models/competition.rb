#coding: utf-8
class Competition < ActiveRecord::Base
  attr_accessible :alku, :logiikka, :loppu, :nimi, :palkintosijat, :saannot, :user_ids, :prizes_attributes, :competition_id
  validates :alku, presence: true
  validates :logiikka, presence: true
  validates :loppu, presence: true
  validates :nimi, presence: true
  validates :saannot, presence: true

  has_and_belongs_to_many :users
  has_many :prizes, :dependent => :destroy
  
  accepts_nested_attributes_for :prizes, :reject_if => lambda { |a| a[:kuvaus].blank? }, :allow_destroy => true

  
  
  def logiikkastring(nro)
    if nro == 1
      return "Eniten myyntiä"
    end
    if nro == 2
      return "Eniten kauppoja"
    end
    if nro == 3
     return "Eniten provisiota"
    end   
  end
  
end
