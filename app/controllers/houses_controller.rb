class HousesController < ApplicationController
  require 'csvparser'
  # GET /houses
  # GET /houses.json
  def index
    @houses = House.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @houses }
    end
  end

  # GET /houses/1
  # GET /houses/1.json
  def show

    @house = House.find(params[:id])
    @house.update_status
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @house }
    end
  end

  # GET /houses/new
  # GET /houses/new.json
  def new
    @house = House.new
    unless session[:house_attributes].empty?
      @house.attributes = session[:house_attributes]
      session[:house_attributes].clear
    end


    respond_to do |format|
      format.html # new.html.erb.erb
      format.json { render json: @house }
    end
  end

  # GET /houses/1/edit
  def edit
    @house = House.find(params[:id])
  end

  # POST /houses
  # POST /houses.json
  def create
    ad_params = params.require(:house).permit!
    @house = House.new(ad_params)

    respond_to do |format|
      if @house.save
        case params[:commit].to_s
          when "Create House and Add Sales"
            format.html { redirect_to new_house_sale_path(@house), notice: "House was successfully created."}
          when "Create House and Add Listings"
            format.html { redirect_to new_house_listing_path(@house), notice: "House was successfully created."}
          else
            format.html { redirect_to @house, notice: "House was successfully created."}

        end

      #   format.json { render json: @house, status: :created, location: @house }
      else
        format.html { render action: "new" }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /houses/1
  # PUT /houses/1.json
  def update

    @house = House.find(params[:id])

    respond_to do |format|
      ad_params = params.require(:house).permit!
      if @house.update_attributes(ad_params)
        format.html { redirect_to @house, notice: 'Success!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house = House.find(params[:id])
    @house.destroy

    respond_to do |format|
      format.html { redirect_to houses_searchresults_path }
      format.json { head :no_content }
    end
  end

  def search
    @search = House.search(params[:q])
    @houses = @search.result
  end

  def searchresults

    @search = House.search(params[:q])
    @houses = @search.result

  end

  def viewall
    @search = House.search(params[:q])
    @houses = @search.result
    @q = Listing.search(params[:all])
    @q.build_condition

  end

  def statusupdate
    @house = House.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @house }
    end
  end

  def show_multiple
    @houses = House.find(params[:house_ids])
  end

  def addattach
    @house = House.find(params[:id])

  end

  def editattach
    @housefiles = Housefile.all
    @house = House.find(params[:id])

  end

  def pdfconverter

  end

  def pdfupload
    pdffile = params[:datafile]
    name =  pdffile.original_filename
    directory = "public/pdffiles" # specify yr own path in public folder
    csvfile = "#{Rails.root}/" + directory + "/housedata.csv"
    # create the file path
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(pdffile.read) }
    if pdffile.content_type.include? 'pdf'
      puts "java -jar C:\\Tabula\\tabula-0.9.1-jar-with-dependencies.jar \"#{Rails.root}/" + path+ "\" -g -p all -r -o \""+ csvfile +"\""
      Process.wait(IO.popen("java -jar C:\\Tabula\\tabula-0.9.1-jar-with-dependencies.jar \"#{Rails.root}/" + path+ "\" -g -p all -r -o \""+ csvfile +"\"").pid )
      File.delete(path)
    else
      csvfile = "#{Rails.root}/" + path
    end
  # write the file

    csvparse = CsvParser.new((csvfile),params[:county])
    csvparse.run
    if csvparse.house_exists
      session[:sales] = csvparse.get_sales
      house = csvparse.get_house
      flash[:notice] = "House Already Exists. Sales Information Does Not."
      redirect_to new_house_sale_path(house)
    else
      session[:house_attributes] = csvparse.get_house.attributes
      session[:sales] = csvparse.get_sales
      File.delete(csvfile)
      redirect_to new_house_path
    end

  end
end
