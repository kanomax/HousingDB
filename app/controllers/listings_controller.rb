class ListingsController < ApplicationController
 before_filter :get_house
  
 def get_house
 @house = House.find(params[:house_id])
 end
 
 def show
 @listing = @house.listings.find(params[:id])
 end
 
 def create
 @listing = @house.listings.new(params[:listing])
  if @listing.save
  flash[:notice] = "Listing Information was successfully added."
  if @listing.listingdate > @house.sales.find(:first, :order => "saledate DESC").saledate
    if @listing.listingdate >= @house.listings.find(:first, :order => "listingdate DESC").listingdate
      @house.update_attributes(:currentprice => @listing.listingprice, :status => 'Listed')
    end    
  end
  redirect_to house_path(@house)
      else
 render action: "new"
  end
 end
 
 def new 
@listing = Listing.new
 end
 
 def index
   @search = Listing.search(:house_id_eq => params[:house_id])
       @listings = @search.result
 end
end
