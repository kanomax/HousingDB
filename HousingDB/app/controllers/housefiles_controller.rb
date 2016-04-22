class HousefilesController < ApplicationController
  
  def create
    @housefile = Housefile.new(params[:housefile])
    @housefile.file = params[:file]
    @housefile.house_id = params[:house_id]
    @house = House.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @house }
    end 
  end
  
  def destroy
    @housefile = Housefile.find(params[:id])
    @houseid = @housefile.house_id
    @housefile.destroy

    respond_to do |format|
      format.html { redirect_to addattach_house(@houseid)}
      format.json { head :no_content }
    end
  end
end
