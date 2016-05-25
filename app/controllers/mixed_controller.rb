class MixedController < ApplicationController
  before_filter :get_house

  def get_house
    if params[:house_id] != nil
      @house = House.find(params[:house_id])
    end
  end

  def salesandlistings
    list = []
    list += Sale.where(house_id: params[:id]).order(:saledate).map do |sale|
      Posting.new("Sale", sale.price,sale.saledate,sale.agent.name?)
    end
    list += Listing.where(house_id: params[:id]).order(:listingdate).map do |listing|
      Posting.new("Listing",listing.listingprice,listing.listingdate,listing.agent.name?)
    end
    @postings = list.sort_by(&:date).reverse
    # @search = @postings.search(params[:search])
    # @sales = @search.result
  end


end