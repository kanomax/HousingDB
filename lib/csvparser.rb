class CsvParser
  def initialize(csvdirectory,county)
    @csvdirectory = csvdirectory
    @house = House.new
    @house.county = county
    @house.outbuilding = ""
  end

  def run()
    @csvarr = CSV.read(@csvdirectory)
    @csvarr.each_with_index do |x,index |
      case x[0]
        when "Parcel Information"
          @parcelindex = index
        when ""
          @assessedindex = index
        when "Yearly Tax Information"
          @yearlytaxindex = index
        when "2015 Tax Levy"
          @taxlevyindex = index
        when "Sales Information"
          @salesinfoindex = index
        when "Property Classification"
          @propertyclassindex = index
        when "Residential Datasheet"
          @resdataindex = index
        when "Dwelling Data","Miscellaneous Improvements"
          @dwellingdataindex = index
        when "Outbuilding Data"
          @outbuildingdataindex = index
      end
    end
    self.parcelinfoparser
    self.saleinfoparser
    self.resdataparser
    self.dwellingdataparser
    unless @outbuildingdataindex.nil?
      self.outbuildingparser
    end
  end

  def parcelinfoparser
    parcelarr = @csvarr[@parcelindex..@assessedindex]
    parcelarr.each do |x|
      value = x[1]
      case x[0]
        when /Parcel ID/
          @house.parcel_id = value
        when /Situs Address/

          @house.address = value.downcase.split(" ").collect{|word| word[0] = word[0].upcase; word}.join(" ")
        when /Legal Description/
          value = value.split
          case @house.county
            when "Fillmore"
              city = value[(value.length - 2)].humanize
              @house.city = city
              state = value[(value.length - 1)]
              @house.state = state
              @house.zipcode = (city + ", " + state).to_zip
            when "Saline"
              city = value[0].humanize
              @house.city = city
              state = "NE"
              @house.state = state
              @house.zipcode = (city + ", " + state).to_zip
          end
        when "Lot Width x Depth"
          if @house.county == "Saline"
            unless value.nil?
              value = value.split('x')
              int1 = value[0].to_i
              int2 = value[1].to_i
              @house.lotsize = int1 * int2
            end
          end
        when "Lot Size:"
          value = value.split
          @house.lotsize = value[0].to_i
      end
    end
  end

  def saleinfoparser

  end

  def resdataparser
    resdataarr = @csvarr[@resdataindex..@dwellingdataindex]
    col1 = Array.new
    col2 = Array.new
    resdataarr.each do |x|
      col1.push(x[0..1])
      col2.push(x[2..3])
    end
    col1.each do |x|
      unless x.nil?
        value = x[1]
        case x[0]
          when "Building Size:","Total Area"
            value = value.split
            @house.squarefeet = value[0].gsub!(',','')
          when /Year Built/
            @house.year = value
          when "Quality:","Quality / Condition"
            case @house.county
              when "Fillmore"
                quality = value
              when "Saline"
                value  = value.split("/")
                quality = value[0]
                condition = value [1]
            end
            unless quality.nil?
              case quality
                when /Excellent/
                  @house.quality = "Q1"
                when /Very Good/
                  @house.quality = "Q2"
                when /Good/
                  @house.quality = "Q3"
                when /Average/
                  @house.quality = "Q4"
                when /Fair/
                  @house.quality = "Q5"
                when /Poor/
                  @house.quality = "Q6"
                else
                  @house.quality = "Other"
              end
            end
            unless condition.nil?
              case condition
                when /Excellent/
                  @house.condition = "C1"
                when /Very Good/
                  @house.condition = "C2"
                when /Good/
                  @house.condition = "C3"
                when /Average/
                  @house.condition = "C4"
                when /Fair/
                  @house.condition = "C5"
                when /Poor/
                  @house.condition = "C6"
                else
                  @house.condition = "Other"
              end
            end
          when "Exterior:","Ext. Wall 1"
            value = value.downcase
            if value.include? "vinyl"
              @house.siding = "Vinyl"
            elsif value.include? "wood"
              @house.siding = "Wood"
            elsif value.include? "hardboard"
              @house.siding = "Hardboard"
            elsif value.include? "permanent"
              @house.siding = "Permanent"
            elsif value.include? "brick"
              @house.siding = "Brick"
            elsif value.include? "masonry"
              @house.siding = "Masonry"
            elsif value.include? "metal"
              @house.siding = "Metal"
            elsif value.include? "cement board"
              @house.siding = "Cement Board"
            elsif value.include? "stucco"
              @house.siding = "Stucco"
            else
              @house.siding = "Other"
            end
          when "Style:","Style 1"
            if value.include? "1 Story" or value.include? "One-Story" or value.include? "One Story"
              @house.style = "One Story"
            elsif value.include? "1 1/2 Story"
              @house.style = "1.5 Story"
            elsif value.include? "2 Story"
              @house.style = "Two Story"
            elsif value.include? "3 Story"
              @house.style = "Three Story"
            elsif value.include? "Split Level"
              @house.style = "Split Level"
            else
              @house.style = "Other"
            end
          when /Bedrooms/
            @house.bedrooms = value
          when /Bathrooms/
            @house.bathrooms = value
          when "Heating/Cooling:"
          when "Basement Size:","Basement Area"
            value = value.split
            @house.basementsf = value[0].gsub!(',','')
          when /Min Finish/
            unless value.nil?
              value = value.split
              @house.basementsffinish = value[0].gsub!(',','') || value[0]
            end
          when "Garage:","Garage Type"
            unless value.nil?
              garagestalls = ""
              case value
                when "Attached Garage (SF)","ATTACHED"
                  garagestalls = "Attached"
              end
              if @house.garagestalls.nil?
                @house.garagestalls = garagestalls
              else
                @house.garagestalls = @house.garagestalls + " " + garagestalls
              end
            end
          when "Garage Size:","Garage Area"
           if value.nil? and !@house.garagestalls.nil?
             @house.garagestalls = "1 " + @house.garagestalls
           elsif !value.nil?
             value = value.split
             value = value[0].to_i
             if value > 875
               garagenumber = "3"
             elsif value.between?(551, 875)
               garagenumber = "2"
             else
               garagenumber = "1"
             end
             if @house.garagestalls.nil?
               @house.garagestalls = garagenumber
             else
               @house.garagestalls = garagenumber + " " + @house.garagestalls
             end
           end

        end
      end
    end
    col2.each do |x|
      unless x.nil?
        value = x[1]
        case x[0]
          when "Building Size:","Total Area"
            value = value.split
            @house.squarefeet = value[0].gsub!(',','')
          when /Year Built/
            @house.year = value
          when "Quality:","Quality / Condition"
            case @house.county
              when "Fillmore"
                quality = value
              when "Saline"
                value  = value.split("/")
                quality = value[0]
                condition = value [1]
            end
            unless quality.nil?
              case quality
                when /Excellent/
                  @house.quality = "Q1"
                when /Very Good/
                  @house.quality = "Q2"
                when /Good/
                  @house.quality = "Q3"
                when /Average/
                  @house.quality = "Q4"
                when /Fair/
                  @house.quality = "Q5"
                when /Poor/
                  @house.quality = "Q6"
                else
                  @house.quality = "Other"
              end
            end
            unless condition.nil?
              case condition
                when /Excellent/
                  @house.condition = "C1"
                when /Very Good/
                  @house.condition = "C2"
                when /Good/
                  @house.condition = "C3"
                when /Average/
                  @house.condition = "C4"
                when /Fair/
                  @house.condition = "C5"
                when /Poor/
                  @house.condition = "C6"
                else
                  @house.condition = "Other"
              end
            end
          when "Exterior:","Ext. Wall 1"
            value = value.downcase
            if value.include? "vinyl"
              @house.siding = "Vinyl"
            elsif value.include? "hardboard"
              @house.siding = "Hardboard"
            elsif value.include? "permanent"
              @house.siding = "Permanent"
            elsif value.include? "brick"
              @house.siding = "Brick"
            elsif value.include? "masonry"
              @house.siding = "Masonry"
            elsif value.include? "metal"
              @house.siding = "Metal"
            elsif value.include? "cement board"
              @house.siding = "Cement Board"
            elsif value.include? "stucco"
              @house.siding = "Stucco"
            elsif value.include? "wood" or value.include? "siding"
              @house.siding = "Wood"
            else
              @house.siding = "Other"
            end
          when "Style:","Style 1"
            if value.include? "1 Story" or value.include? "One Story" or value.include? "One-Story"
              @house.style = "One Story"
            elsif value.include? "1 1/2 Story"
              @house.style = "1.5 Story"
            elsif value.include? "2 Story"
              @house.style = "Two Story"
            elsif value.include? "3 Story"
              @house.style = "Three Story"
            elsif value.include? "Split Level"
              @house.style = "Split Level"
            else
              @house.style = "Other"
            end
          when /Bedrooms/
            @house.bedrooms = value
          when /Bathrooms/
            @house.bathrooms = value
          when "Heating/Cooling:","Heat Type"
            value = value.downcase
            case value
              when /radiator/
                @house.heating = "Radiator"
              when /heat pump/
                @house.heating = "Heat Pump"
                @house.cooling = "Heat Pump"
              when /floor furnace/
                @house.heating = "Baseboard"
            end
          when "Basement Size:","Basement Area"
            value = value.split
            value = value[0].gsub!(',','') || value[0]
            value = value.gsub('sq.','') || value
            @house.basementsf = value
          when /Min Finish/
            unless value.nil?
              value = value.split
              @house.basementsffinish = value[0].gsub!(',','') || value[0]
            end
          when "Garage:","Garage Type"
            unless value.nil?
              garagestalls = ""
              case value
                when "Attached Garage (SF)","ATTACHED"
                  garagestalls = "Attached"
              end
              if @house.garagestalls.nil?
                @house.garagestalls = garagestalls
              else
                @house.garagestalls = @house.garagestalls + " " + garagestalls
              end
            end
          when "Garage Size:","Garage Area"
            if value.nil? and !@house.garagestalls.nil?
              @house.garagestalls = "1 " + @house.garagestalls
            elsif !value.nil?
              value = value.split
              value = value[0].to_i
              if value > 875
                garagenumber = "3"
              elsif value.between?(551, 875)
                garagenumber = "2"
              else
                garagenumber = "1"
              end
              if @house.garagestalls.nil?
                @house.garagestalls = garagenumber
              else
                @house.garagestalls = garagenumber + " " + @house.garagestalls
              end
            end
        end
      end
    end
  end

  def dwellingdataparser
    if @outbuildingdataindex.nil?
      dwellingdataarr = @csvarr[@dwellingdataindex..(@csvarr.length - 4)]
    else
      dwellingdataarr = @csvarr[@dwellingdataindex..@outbuildingdataindex - 1]
    end

    genstring = ""
    buildingstring = ""
    dwellingdataarr.each_with_index do |x,index|
      if index != 0 and index != 1
        value = x[0].downcase
      end
      unless value.nil?
        case value
          when /fire pl/, /firepl/
            if value.include? "single"
              @house.fireplaces = 1
            end
          when /concrete drive/
            @house.concretedrive = true
          when /shed/
            buildingstring = buildingstring + value + "\n"
          when /sprklr/, /sprinkler/
            @house.sprinklers = true
          else
            genstring = genstring + value + "\n"
        end
      end
    end
    @house.gencomments = genstring
    @house.outbuilding = @house.outbuilding + buildingstring
  end

  def outbuildingparser
    outbuildingarr = @csvarr[@outbuildingdataindex..(@csvarr.length - 3)]
    tempstring = ""
    outbuildingarr.each_with_index do |x,index|
      if index != 0 and index != 1
        value = x[0].downcase
        tempstring = tempstring + value + "\n"
      end
    end
    @house.outbuilding = @house.outbuilding + tempstring
  end

  def gethouse
    return @house
  end
end