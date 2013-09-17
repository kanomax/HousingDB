class SalesController < ApplicationController
 before_filter :get_house
 
 def get_house
 @house = House.find(params[:house_id])
 end
 
 def show
 @sale = @house.sales.find(params[:id])
 end
 
 def create
 @sale = @house.sales.new(params[:sale])
  if @sale.save
  flash[:notice] = "Sale Information was successfully added."
  
  if @sale.saledate >= @house.sales.find(:first, :order => "saledate DESC").saledate
    if @sale.saledate >= @house.listings.find(:first, :order => "listingdate DESC").listingdate
      @house.update_attributes(:currentprice => @sale.price, :status => 'Sold')
    end    
  end
  redirect_to house_path(@house)
   
  else
    render action: "new"
  end
 end
 
 def new 
@sale = Sale.new
 end
 
 def index
      @search = @house.sales.search(params[:search])
       @sales = @search.result
 end
end
