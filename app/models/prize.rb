class Prize < ActiveRecord::Base
  attr_accessible :kuvaus, :arvo, :competition_id
  belongs_to :competition
  
end
