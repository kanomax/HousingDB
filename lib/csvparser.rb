class CsvParser
  def initialize(csvdirectory)
    @csvdirectory = csvdirectory
    @house = House.new
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
        when "Dwelling Data"
          @dwellingdataindex = index
      end
    end
    self.parcelinfoparser
    self.saleinfoparser
    self.resdataparser
    self.dwellingdataparser
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
          city = value[(value.length - 2)].humanize
          @house.city = city
          state = value[(value.length - 1)]
          @house.state = state
          @house.zipcode = (city + ", " + state).to_zip
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
          when "Building Size:"
            value = value.split
            @house.squarefeet = value[0].gsub!(',','')
          when "Year Built:"
            @house.year = value
          when "Quality:"
            case value
              when "Excellent"
                @house.quality = "Q1"
              when "Very Good"
                @house.quality = "Q2"
              when "Good"
                @house.quality = "Q3"
              when "Average"
                @house.quality = "Q4"
              when "Fair"
                @house.quality = "Q5"
              when "Poor"
                @house.quality = "Q6"
              else
                @house.quality = "Other"
            end
          when "Exterior:"
            if value.include? "Vinyl"
              @house.siding = "Vinyl"
            elsif value.include? "Wood"
              @house.siding = "Wood"
            elsif value.include? "Hardboard"
              @house.siding = "Hardboard"
            elsif value.include? "Permanent"
              @house.siding = "Permanent"
            elsif value.include? "Brick"
              @house.siding = "Brick"
            elsif value.include? "Masonry"
              @house.siding = "Masonry"
            elsif value.include? "Metal"
              @house.siding = "Metal"
            elsif value.include? "Cement Board"
              @house.siding = "Cement Board"
            elsif value.include? "Stucco"
              @house.siding = "Stucco"
            else
              @house.siding = "Other"
            end
          when "Style:"
            if value.include? "1 Story"
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
          when "Bedrooms:"
            @house.bedrooms = value
          when "Bathrooms:"
            @house.bathrooms = value
          when "Heating/Cooling:"
          when "Basement Size:"
            value = value.split
            @house.basementsf = value[0].gsub!(',','')
          when "Min Finish:\nPart Finish:"
            value = value.split
            @house.basementsffinish = value[0].gsub!(',','')
          when "Garage:"
            case value
              when "Attached Garage (SF)"
                @house.garagestalls = "1 Attached"
            end
        end
      end
    end
    col2.each do |x|
      unless x.nil?
        value = x[1]
        case x[0]
          when "Building Size:"
            value = value.split
            @house.squarefeet = value[0].gsub!(',','')
          when "Year Built:"
            @house.year = value
          when "Quality:"
            case value
              when "Excellent"
                @house.quality = "Q1"
              when "Very Good"
                @house.quality = "Q2"
              when "Good"
                @house.quality = "Q3"
              when "Average"
                @house.quality = "Q4"
              when "Fair"
                @house.quality = "Q5"
              when "Poor"
                @house.quality = "Q6"
              else
                @house.quality = "Other"
            end
          when "Exterior:"
            if value.include? "Vinyl"
              @house.siding = "Vinyl"
            elsif value.include? "Wood"
              @house.siding = "Wood"
            elsif value.include? "Hardboard"
              @house.siding = "Hardboard"
            elsif value.include? "Permanent"
              @house.siding = "Permanent"
            elsif value.include? "Brick"
              @house.siding = "Brick"
            elsif value.include? "Masonry"
              @house.siding = "Masonry"
            elsif value.include? "Metal"
              @house.siding = "Metal"
            elsif value.include? "Cement Board"
              @house.siding = "Cement Board"
            elsif value.include? "Stucco"
              @house.siding = "Stucco"
            else
              @house.siding = "Other"
            end
          when "Style:"
            if value.include? "1 Story" or value.include? "One Story"
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
          when "Bedrooms:"
            @house.bedrooms = value
          when "Bathrooms:"
            @house.bathrooms = value
          when "Heating/Cooling:"
          when "Basement Size:"
            value = value.split
            @house.basementsf = value[0].gsub!(',','')
          when "Min Finish:\nPart Finish:"
            value = value.split
            @house.basementsffinish = value[0].gsub!(',','')
          when "Garage:"
            case value
              when "Attached Garage (SF)"
                @house.garagestalls = "1 Attached"
            end
        end
      end
    end
  end
  def dwellingdataparser
    dwellingdataarr = @csvarr[@dwellingdataindex..(@csvarr.length - 3)]
    tempstring = ""
    dwellingdataarr.each_with_index do |x,index|
      if index != 0 and index != 1
        tempstring = tempstring + x[0] + "\n"
      end
    end
    @house.gencomments = tempstring
  end
  def gethouse
    return @house
  end
end