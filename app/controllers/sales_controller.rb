class SalesController < ApplicationController
before_filter :get_house
 
 def get_house
 if params[:house_id] != nil
   @house = House.find(params[:house_id])
 end    
 end
 
 def show
 @sale = @house.sales.find(params[:id])
 end
 
 def create
 @sale = @house.sales.new(params[:sale])
  if @sale.save

  
  if @sale.saledate >= @house.sales.find(:first, :order => "saledate DESC").saledate
    if  @house.listings.find(:first, :order => "listingdate DESC") == nil
      @house.update_attributes(:currentprice => @sale.price, :status => 'Sold')
    elsif @sale.saledate >= @house.listings.find(:first, :order => "listingdate DESC").listingdate
      @house.update_attributes(:currentprice => @sale.price, :status => 'Sold')
    end    
  end
  if params[:agentsubmit]
    redirect_to agentadd_sale_path(@sale)
  
  else    
    flash[:notice] = "Sale Information was successfully added."
    redirect_to house_path(@house)
  end
   
  else
    render action: "new"
  end
 end
 
 def new 
@sale = Sale.new
 end
 
 def edit
    @sale = Sale.find(params[:id])
 end

 def index
      @search = @house.sales.search(params[:search])
       @sales = @search.result
 end
   def agentadd
    @sale = Sale.find(params[:id])
    @search = Agent.search(params[:q])
    @agents = @search.result
  end
  
  def update
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to root_path, notice: 'Agent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
