class ListingsController < ApplicationController
 before_filter :get_house
  
 def get_house
  if params[:house_id] != nil
   @house = House.find(params[:house_id])
 end 
 end
 
 def show
 @listing = @house.listings.find(params[:id])
 end
 
 def create
  ad_params = params.require(:listing).permit!
 @listing = @house.listings.new(ad_params)
  if @listing.save
   if @listing.listingdate >= @house.listings.order('listingdate DESC').first.listingdate
    if @house.sales.order('saledate DESC').first == nil
      @house.update_attributes(:currentprice => @listing.listingprice, :status => 'Listed')
    elsif @listing.listingdate > @house.sales.order('saledate DESC').first.saledate
      @house.update_attributes(:currentprice => @listing.listingprice, :status => 'Listed')
    end    
   end
   if params[:agentsubmit]
    redirect_to agentadd_listing_path(@listing)
  
   else    
    flash[:notice] = "Listing Information was successfully added."
    redirect_to house_listings_path(@house)
  end
      else
 render action: "new"
  end
 end
 
  def agentadd
    @listing = Listing.find(params[:id])
    @search = Agent.search(params[:q])
    @agents = @search.result
  end
  
    def update
    @listing = Listing.find(params[:id])

    respond_to do |format|
      ad_params = params.require(:listing).permit!
      if @listing.update_attributes(ad_params) and params[:param1] == nil
        format.html { redirect_to house_listings_path(@house), notice: 'Agent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render edit_house_listing_path(@house,@listing) }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end
  
 def new 
@listing = Listing.new
@agentname = "No Agent"
 end
 def edit
 @listing = Listing.find(params[:id])
   if @listing.agent.nil?
     @agentname = "No Agent"
   else
     @agentname = @listing.agent.name
   end
 end
 def index
   @search = Listing.search(:house_id_eq => params[:house_id])
       @listings = @search.result
 end

 def destroy
   @house = Listing.find(params[:id])
   @house.destroy

   respond_to do |format|
     format.html { redirect_to house_listings_path(@house) }
     format.json { head :no_content }
   end
end
end