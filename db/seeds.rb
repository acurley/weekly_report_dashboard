# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
property_names = {
  "Arbor Crest" => ["Arbor Crest", "ac", "ac Arbor Crest Landmark Property Services,Inc"],
  "Barter Court" => ["BC", "Barter Court"],
  "Berkshire" => ["Berkshire", "bk", "bk Berkshire Apts Landmark Property Services,Inc"],
  "Brookview" => ["Brookview", "bv", "bv Brookview Landmark Property Services,Inc"],
  "Cameron" => ["Cameron", "CB"],
  "Colonial Heights and Township" => ["Colonial Heights and Township", "ch", "ts", "ch Colonial Heights, LL Landmark Property Services,Inc"],
  "Cloverleaf Lake" => ["cl", "Cloverleaf Lake", "cl Cloverleaf Lake Landmark Property Services,Inc"],
  "Creekpointe" => ["Creekpointe", "cp", "cp Creekpointe Landmark Property Services,Inc"],
  "Glenns at Millers Lane" => ["Glenns at Millers Lane", "gm", "gm Glenns @ Miller Lane Landmark Property Services,Inc"],
  "Hamptons" => ["Hamptons", "hm", "hm Hamptons Landmark Property Services,Inc"],
  "Hickory Point" => ["Hickory Point", "hp", "hp Hickory Point Landmark Property Services,Inc"],
  "Hilliard Road" => ["Hilliard Road", "hr", "hr Hilliard Road Landmark Property Services,Inc"],
  "Longhill Grove" => ["Longhill Grove", "lh", "lh Longhill Landmark Property Services,Inc"],
  "Lieutenants Run" => ["Lieutenants Run", "lr", "lr Lieutenant's Run Landmark Property Services,Inc"],
  "Misty Pines" => ["Misty Pints", "ma", "ma Misty Pines Apartmen Landmark Property Services,Inc"],
  "Match Point" => ["Match Point", "mp", "mp Match Point Landmark Property Services,Inc"],
  "Mayfair" => ["Mayfair", "MY", "MY Mayfair Landmark Property Services,Inc"],
  "North Dunlop" => ["North Dunlop", "nd"],
  "North Slope" => ["North Slope", "ns", "ns North Slope Landmark Property Services,Inc"],
  "Old Bridge" => ["Old Bridge", "ob", "ob Old Bridge Landmark Property Services,Inc"],
  "Overlook at Brook Run" => ["Overlook at Brook Run", "ol", "om", "ol Overlook Phase I Landmark Property Services,Inc"],
  "Perry Street" => ["Perry Street", "ps", "ps Perry Street Landmark Property Services,Inc"],
  "Southgate Manor" => ["Southgate Manor", "SF", "SG", "SG Southgate Manor PH I Landmark Property Services,Inc"],
  "Stratford Hills and Bethany Springs" => ["Stratford Hills and Bethany Springs", "sh", "bs", "sh Stratford Hills Landmark Property Services,Inc", "bs Bethany Springs Landmark Property Services,Inc"],
  "Sand Ridge" => ["Sand Ridge", "SR", "SS", "ST", "SR Sand Ridge Phase III Landmark Property Services,Inc"],
  "Tamarack" => ["Tamarack", "TM", "TN", "TM Tamarack Phase II Landmark Property Services,Inc"],
  "Tanglewood" => ["Tanglewood", "tw", "tx", "tw Tanglewood Apartment Landmark Property Services,Inc"],
  "Willow Oaks" => ["Willow Oaks", "wo", "wo Willow Oaks Landmark Property Services,Inc"]
}

property_names.each {|key, value|
  p = Property.create!(name: "#{key}")
  value.each {|v|
    AlternateName.create!(name: v, property_id: p.id)
  }
}