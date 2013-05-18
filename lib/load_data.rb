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
        alternate_names = AlternateName.where(:name => property_code.downcase)
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
      property = AlternateName.where(:name => property_code.downcase).first.property
      stat = Stat.find_or_create_by_date_retrieved_and_property_id(date, property.id)
      row_number = @doc.xpath("count(/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row)").to_i
      stat.total_guest_cards += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number - 1}]/ss:Cell[3]/ss:Data[1]/text()").to_s.to_i
      stat.total_apps += @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{row_number - 1}]/ss:Cell[4]/ss:Data[1]/text()").to_s.to_i
      stat.save!
    }
  end

  def self.load_reasons_analysis(date=nil)
    if date.nil?
      date = Date.today.to_s
    else
      date = date
    end

    files = Dir.entries("#{Dir.home}/Dropbox/Programming/dashboard_work/weekly_report_data/#{date}/reasons_analysis").delete_if {|x| x == '.' or x == '..' or /pdf/ =~ x}
    files.each {|file|
      @doc = Nokogiri.XML(File.read("#{Dir.home}/Dropbox/Programming/dashboard_work/weekly_report_data/#{date}/reasons_analysis/#{file}")) { |cfg| cfg.noblanks }
      property_code = @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[4]/ss:Cell[1]/ss:Data[1]/html:Font[1]/text()").to_s
      property_code = property_code.gsub(/\n/, '').squeeze(' ')
      property = AlternateName.where(:name => property_code.downcase).first.property

      # After finding the stat value in question, zero out values so data can be refreshed.
      stat = Stat.find_or_create_by_date_retrieved_and_property_id(date, property.id)
      stat.update_attributes(:applications_cancelled => 0, :applications_processed => 0, :applications_rejected => 0, :percent_applications_rejected => 0, :percent_applications_cancelled => 0, :percent_applications_rejected_and_cancelled => 0)

      # Since many of the XML files have incorrect data in the totals row, we must ignore it in all cases.
      # So to determine totals we will:
      # 1. Find the first row (contains Building, Reason, etc... as a header row)
      # 2.  Determine if last row is a total row. 
      # 3. Analyze every row afterwards
      # 3.

      # Do cell numbers reveal what kind of document we are dealing with

      number_of_rows = @doc.xpath('//ss:Row').count

      # The first row number for analysis is +1 of the row which has header information.
      header_row_number = @doc.search("[text()*='Building']").first.ancestors('Row').attribute('Index').value.to_i

      # Return a boolean value to see if the last row is a "total" row (i.e. to be ignored)
      project_total_row = @doc.search("[text()*='Project Totals']")
      if project_total_row
        last_row_number = project_total_row.first.ancestors('Row').attribute('Index').value.to_i
      else

      end
      last_row_is_total = @doc.xpath("/ss:Workbook/ss:Worksheet[1]/ss:Table[1]/ss:Row[#{number_of_rows - 1}]/ss:Cell[2]/ss:Data[1]/html:Font[1]/text()").text == "Project Totals"

      if last_row_is_total
        rows_to_inspect = (header_row_number..(number_of_rows - 2 ))
      else
        rows_to_inspect = (header_row_number..(number_of_rows - 1))
      end

      total_apps = 0; apps_rejected = 0; apps_cancelled = 0
      rows_to_inspect.to_a.each {|row_number|
        # determine if there is more than one cell (indicative that there is real data here)
        if @doc.xpath("//ss:Row[#{row_number + 1}]/ss:Cell[2]")
          total_apps += @doc.xpath("//ss:Row[#{row_number + 1}]/ss:Cell[3]/ss:Data[1]").first.text.gsub(/Applications: /, '').to_i
          apps_rejected += @doc.xpath("//ss:Row[#{row_number + 1}]/ss:Cell[4]/ss:Data[1]").first.text.split(/ /).first.to_i
          apps_cancelled += @doc.xpath("//ss:Row[#{row_number + 1}]/ss:Cell[8]/ss:Data[1]").first.text.split(/ /).first.to_i
          puts "Total apps: #{total_apps}"
          puts "Apps rejected: #{apps_rejected}"
          puts "Apps cancelled: #{apps_cancelled}"
        end
      }

      stat.applications_processed = total_apps
      stat.applications_rejected = apps_rejected
      stat.applications_cancelled = apps_cancelled

      puts stat.applications_processed
      puts stat.applications_rejected
      puts stat.applications_cancelled 
      stat.save!
    }
  end

  def self.calculate_percentages(date=nil)
    if date.nil?
      date = Date.today.to_s
    else
      date = date
    end

    # Calculate all percentages based on information in the 50F
    todays_stats = Stat.where(:date_retrieved => date)
    todays_stats.each {|stat|
      stat.percent_occupied = stat.current_occupied.to_f / stat.property.total_units.to_f
      stat.percent_preleased = (stat.percent_preleased.to_f / stat.property.phases) / 100
      stat.percent_applications_rejected = stat.applications_rejected.to_f / stat.applications_processed.to_f
      stat.percent_applications_cancelled = stat.applications_cancelled.to_f / stat.applications_processed.to_f
      stat.percent_applications_rejected_and_cancelled = (stat.applications_cancelled.to_f + stat.applications_rejected.to_f) / stat.applications_processed.to_f
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

end