class Listing < ActiveRecord::Base
belongs_to :house
belongs_to :agent
  
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

  def update_house(house)
    if self.listingdate >= house.listings.order('listingdate DESC').first.listingdate
      if house.sales.order('saledate DESC').first == nil
        house.update_attributes(:currentprice => self.listingprice, :status => 'Listed')
      elsif self.listingdate > house.sales.order('saledate DESC').first.saledate
        house.update_attributes(:currentprice => self.listingprice, :status => 'Listed')
      end
    end
  end


end


