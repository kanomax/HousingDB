class HousesController < ApplicationController
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

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @house }
    end
  end

  # GET /houses/new
  # GET /houses/new.json
  def new
    @house = House.new

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
        format.html { redirect_to @house, notice: "House was successfully created."}
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
    doc = Nokogiri::HTML(File.open("C:\\HousingDB\\public\\pdffiles\\report.html"))
    @tables = doc.search('table')
    @salearr = Array.new
    @tables.each do |x|
      parcels = x.search "[text()*='Parcel ID']"
      if !parcels.blank?
      parcel = parcels.first
      @parcelid = parcel.parent.next_element.text        
      end

      tempstr = x.at('tr p').text
      
      if tempstr == "Sales Information"


        trctr = 0
        arrctr = 0
        tr = x.search('tr')
        tr.each do |y|
          @rowarr = Array.new
          if trctr > 1  
            td = y.search('td')
            td.each do |z|         
              @rowarr << z.text
            end
          end
          if !@rowarr.empty?
            @salearr << @rowarr            
          end
        trctr = trctr + 1
        end
      elsif tempstr == "Residential Building Information"
          tr = x.search('tr')
          tr.each do |y|
            td = y.search('td')
            td.each do |z|
              if z.text == "Rooms Above Ground"
                @ragtext = z.next_element.text            
              elsif z.text == "Rooms Below Ground"
                @rbgtext = z.next_element.text                 
              elsif z.text == "Year Built"
                @yeartext = z.next_element.text                   
              elsif z.text == "Style"
                @styletext = z.next_element.text                 
              elsif z.text == "Area"
                @areatext = z.next_element.text                 
              elsif z.text == "Bathroom #"
                @bathtext = z.next_element.text                 
              elsif z.text == "TLA"
                
              elsif z.text == "Basement Area"
                
              elsif z.text == "Heating"
              
              elsif z.text == "Flooring"
              
              elsif z.text == "AC"
                
              elsif z.text == "Condition Code"
                
              elsif z.text == "TLA"
                
              elsif z.text == "TLA"
                
              end
            end
          end
          
      end
      
    end
    
  end

  def pdfupload
    pdffile = params[:datafile]
    name =  pdffile.original_filename
    directory = "public/pdffiles" # specify yr own path in public folder
   # create the file path
    path = File.join(directory, name)
  # write the file
    File.open(path, "wb") { |f| f.write(pdffile.read) }
    redirect_to root_path
  end
end
