class Bonuslevel < ActiveRecord::Base
  belongs_to :salegroup
  attr_accessible :bonus_maara, :ehto, :kriteeri, :laji, :salegroup_id, :tasonro
  validates :bonus_maara, presence: true
  validates :ehto, presence: true
  validates :kriteeri, presence: true
  validates :laji, presence: true
  validates :salegroup_id, presence: true
end
