class Bonuslevel < ActiveRecord::Base
  belongs_to :salegroup
  attr_accessible :bonus_maara, :ehto, :kriteeri, :laji, :salegroup_id, :tasonro
end
