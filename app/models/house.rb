class House < ActiveRecord::Base

has_many :sales
has_many :listings
has_many :housefiles
accepts_nested_attributes_for :housefiles, :reject_if => :all_blank, :allow_destroy => true
validates_presence_of :address, :city, :zipcode, :county, :state
validates_numericality_of :year, :lotsize, :squarefeet, :basementsf, :basementsffinish, :greater_than_or_equal_to => 0, :allow_nil => true, :only_integer => true
validates_numericality_of :fireplaces, :bedrooms, :woodstoves, :basementbd, :basementbath, :bathrooms, :greater_than_or_equal_to => 0, :allow_nil => true
validates :zipcode, :format => { :with => %r{\d{5}(-\d{4})?} }
before_save :default_values
mount_uploader :houseimg, HouseUploader, :mount_on => :houseimg_file_name  
  def default_values
    self.status ||= 'Unknown'
  end

  def get_last_agent
    if self.status == "Sold"
      if self.sales.order(:saledate).last.agent.nil?
        return "No Agent"
      else
        return self.sales.order(:saledate).last.agent.name
      end
    end
    if self.status == "Listed"
      if self.listings.order(:listingdate).last.agent.nil?
        return "No Agent"
      else
        return self.listings.order(:listingdate).last.agent.name
      end
    end
    if self.status == "Listed"
      return "No Agent"
    end
  end
  def update_status
    first_sale = self.sales.order('saledate DESC').first
    first_listing = self.listings.order('listingdate DESC').first
    if first_sale == nil
      if first_listing == nil
        self.update_attributes(:currentprice => "", :status => 'Unknown')
      else
        self.update_attributes(:currentprice => first_listing.price, :status => 'Listed')
      end
    elsif first_listing == nil
      if first_sale == nil
        self.update_attributes(:currentprice => "", :status => 'Unknown')
      else
        self.update_attributes(:currentprice => first_sale.price, :status => 'Sold')
      end
    elsif first_listing.listingdate > first_sale.saledate
      self.update_attributes(:currentprice => first_listing.price, :status => 'Listed')
    else
      self.update_attributes(:currentprice => first_sale.price, :status => 'Sold')
    end
  end
end