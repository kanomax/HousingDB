class Sale < ActiveRecord::Base
belongs_to :house
  has_one :agent
  
  validates :house_id, :saledate, :price, :presence => true
  validates_numericality_of :price, :greater_than_or_equal_to => 0
end

