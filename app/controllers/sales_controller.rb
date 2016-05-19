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
   ad_params = params.require(:sale).permit!
 @sale = @house.sales.new(ad_params)

  if @sale.save

  
  if @sale.saledate >= @house.sales.order('saledate DESC').first.saledate
    if  @house.listings.order('listingdate DESC').first == nil
      @house.update_attributes(:currentprice => @sale.price, :status => 'Sold')
    elsif @sale.saledate >= @house.listings.order('listingdate DESC').first.listingdate
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
 @sale.build_agent
   @agentname = "No Agent"
 end
 
 def edit
    @sale = Sale.find(params[:id])
    if @sale.agent.nil?
      @agentname = "No Agent"
    else
      @agentname = @sale.agent.name
    end
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
     @sale.build_agent

    respond_to do |format|
      ad_params = params.require(:sale).permit!
      if @sale.update_attributes(ad_params)
        format.html { redirect_to house_sales_path(@sale.house_id), notice: 'Agent was successfully updated.' }
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
      format.html { redirect_to house_sales_path(@house) }
      format.json { head :no_content }
    end
  end
end
