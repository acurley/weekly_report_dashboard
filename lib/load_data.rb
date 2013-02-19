module LoadData
  require 'nokogiri'

  def self.load_50f(date=nil)
    if date.nil?
      date = Date.today.to_s
    else
      date = date
    end

    @doc = Nokogiri.XML(File.read("#{Dir.home}/Dropbox/Programming/dashboard_work/weekly_report_data/#{date}/50f/50f.xml"))
    (9..46).each {|row_number|
      property_code = @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number}]/ss:Cell[1]/ss:Data[1]/html:Font[1]/text()").to_s
      puts property_code
      if property_code != "bs"  # Beacuse Statford and Bethany have the same data, we will skip the Bethany data in the 50f.
        alternate_names = AlternateName.where(:name => property_code)
        if !alternate_names.empty?
          property = alternate_names.first.property
          if property
            stat = Stat.find_or_create_by_date_retrieved_and_property_id(date, property.id)
            stat.current_occupied += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number}]/ss:Cell[7]/ss:Data[1]/text()").to_s.to_i
            stat.total_vacants += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number}]/ss:Cell[8]/ss:Data[1]/text()").to_s.to_i
            stat.vacant_rented += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number}]/ss:Cell[10]/ss:Data[1]/text()").to_s.to_i
            stat.vacant_unrented += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number}]/ss:Cell[11]/ss:Data[1]/text()").to_s.to_i
            stat.percent_preleased += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number}]/ss:Cell[13]/ss:Data[1]/html:Font[1]/text()").to_s.gsub(/%/, '').to_f
            stat.save!
          end
        end
      end
    }

    # Calculate all percentages based on information in the 50F
    todays_stats = Stat.where(:date_retrieved => date)
    todays_stats.each {|stat|
      stat.percent_occupied = stat.current_occupied.to_f / stat.property.total_units.to_f
      stat.percent_preleased = (stat.percent_preleased.to_f / stat.property.phases) / 100
      stat.save!
    }
  end

  def self.load_81f(date=nil)
    if date.nil?
      date = Date.today.to_s
    else
      date = date
    end

    files = Dir.entries("#{Dir.home}/Dropbox/Programming/dashboard_work/weekly_report_data/#{date}/81f").delete_if {|x| x == '.' or x == '..' or /pdf/ =~ x}
    files.each {|file|
      @doc = Nokogiri.XML(File.read("#{Dir.home}/Dropbox/Programming/dashboard_work/weekly_report_data/#{date}/81f/#{file}"))
      property_code = @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[4]/ss:Cell[1]/ss:Data[1]/html:Font[1]/text()").to_s
      property_code = property_code.gsub(/\n/, '').squeeze(' ')
      property = AlternateName.where(:name => property_code).first.property
      stat = Stat.find_or_create_by_date_retrieved_and_property_id(date, property.id)
      row_number = @doc.xpath("count(/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row)").to_i
      stat.total_guest_cards += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number - 1}]/ss:Cell[3]/ss:Data[1]/text()").to_s.to_i
      stat.total_apps += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number - 1}]/ss:Cell[4]/ss:Data[1]/text()").to_s.to_i
      stat.save!
    }
  end

  # Leadscore

  # Traffic Analysis
  # Need to get:
  # 1. Total Calls
  # 2. % answered

  # Property TPA

  # Craigslist Portfolio
  # Need:
  # 1. Weekly Total (I20)
  # 2. Total Views (J20)
  # 3. Total average viewers (K20)

  #  Craigslist Portfolio Overview
  # Need:
  # 1.  Total Emails
  # 2. Community

  # 04 Activity report
  # 

end