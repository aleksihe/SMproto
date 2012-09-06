class Goal < ActiveRecord::Base
  attr_accessible :alku, :kohde, :loppu, :maara, :salegroup_id, :tyyppi, :user_id
  belongs_to :salegroup
  belongs_to :user
  
end
