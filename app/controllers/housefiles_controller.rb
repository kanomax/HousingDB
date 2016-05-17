class HousefilesController < ApplicationController
  before_filter :get_house

  def get_house
    if params[:house_id] != nil
      @house = House.find(params[:house_id])
    end
  end


  def new
    @housefile = Housefile.new
  end

  def index
    @housefiles = Housefile.all
  end

  def create
    params.permit!
    multiple_file = params[:housefile][:file]
    multiple_file.each do |single|
    @housefile =  Housefile.new
    @housefile.file = single
    @housefile.house_id = @house.id
    @housefile.save
    end
     flash[:notice] = "Sale Information was successfully added."
     redirect_to house_path(@house)
    # else
    #   respond_to do |format|
    #     format.html { render action: "new" }
    #     format.json { render json: @housefile.errors, status: :unprocessable_entity }
    #   end
    #
    # end

  end
  
  def destroy
    @housefile = Housefile.find(params[:id])
    @houseid = @housefile.house_id
    @house = House.find(@houseid)
    @housefile.destroy

    respond_to do |format|
      format.html { redirect_to house_housefiles_path(@house)}
      format.json { head :no_content }
    end
  end
end
