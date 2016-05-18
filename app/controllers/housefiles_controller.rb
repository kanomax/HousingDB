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
    file_error = false
    if not params[:housefile].nil?
      multiple_file = params[:housefile][:file]
    end
    if not multiple_file.nil?
      multiple_file.each do |single|
        @housefile =  Housefile.new
        @housefile.file = single
        @housefile.house_id = @house.id
        if not @housefile.save
          respond_to do |format|
            flash[:alert] =  @housefile.errors.messages[:file].to_sentence
            format.html { redirect_to action: "new" }
            file_error = true
          end
        end

      end
      if not file_error
        flash[:notice] = "Sale Information was successfully added."
        redirect_to house_path(@house)
      end
    else
      respond_to do |format|
        flash[:alert] =  "No Files Were Selected"
        format.html { redirect_to action: "new" }
      end

    end

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
