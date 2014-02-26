class Listing < ActiveRecord::Base
belongs_to :house
  has_one :agent
  
  validates :house_id, :listingdate, :listingprice, :presence => true
    validates_numericality_of :listingprice, :greater_than_or_equal_to => 0
accepts_nested_attributes_for :agent

def self.ransackable_attributes(auth_object = nil)
    if auth_object == 'limit'
      super & ['listingdate']
    else
      super & ['listingdate']
    end
  end


end


