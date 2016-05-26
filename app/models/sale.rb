class Sale < ActiveRecord::Base
belongs_to :house
belongs_to :agent
  
  validates :house_id, :saledate, :price, :presence => true
  validates_numericality_of :dom, :price, :greater_than_or_equal_to => 0
  accepts_nested_attributes_for :agent
def update_house(house)
  if self.saledate >= house.sales.order('saledate DESC').first.saledate
    if  house.listings.order('listingdate DESC').first == nil
      house.update_attributes(:currentprice => self.price, :status => 'Sold')
    elsif self.saledate >= house.listings.order('listingdate DESC').first.listingdate
      house.update_attributes(:currentprice => self.price, :status => 'Sold')
    end
  end
end

end

