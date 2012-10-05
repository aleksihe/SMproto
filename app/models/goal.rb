class Goal < ActiveRecord::Base
  attr_accessible :alku, :kohde, :loppu, :maara, :salegroup_id, :tyyppi, :user_id
  validates :alku, presence: true
  validates :loppu, presence: true, :numericality => {:greater_than => :alku}
  validates :tyyppi, presence: true
  validates :maara, presence: true
  belongs_to :salegroup
  belongs_to :user
  
end
