class House < ActiveRecord::Base

has_many :sales
has_many :listings
validates_presence_of :address, :city, :zipcode, :county
validates_numericality_of :year, :lotsize, :squarefeet, :bedrooms, :basementsf, :basementsffinish, :greater_than_or_equal_to => 0, :allow_nil => true, :only_integer => true
validates_numericality_of :bathrooms, :greater_than_or_equal_to => 0, :allow_nil => true
validates :zipcode, :format => { :with => %r{\d{5}(-\d{4})?} }

  before_save :default_values
  
  def default_values
    self.status ||= 'Unknown'
  end

  
end