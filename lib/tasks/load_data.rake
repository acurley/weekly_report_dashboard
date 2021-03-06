namespace :load do
  require 'load_data'

  desc "Load all date directories in Dropbox folder"
  task :historical_data => :environment do
    puts "Loading historical data..."
    dirs = Dir.entries("#{Dir.home}/Dropbox/Programming/dashboard_work/weekly_report_data/").delete_if {|x| /201*/ !~ x}
    dirs.each {|date|
      LoadData.load_50f(date)
      LoadData.calculate_percentages
    }
  end

  desc "Load only today's data in Dropbox folder"
  task :current_data => :environment do 
    puts "Loading today's data..."
    LoadData.load_50f
    LoadData.load_81f
    LoadData.load_reasons_analysis
    LoadData.calculate_percentages
  end
end