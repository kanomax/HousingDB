class Sale < ActiveRecord::Base
belongs_to :house
belongs_to :agent
  
  validates :house_id, :saledate, :price, :presence => true
  validates_numericality_of :dom, :price, :greater_than_or_equal_to => 0
  accepts_nested_attributes_for :agent
end

