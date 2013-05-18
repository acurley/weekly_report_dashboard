# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
property_names = {
  "Arbor Crest"=> ["arbor crest", "ac", "ac arbor crest landmark property services,inc"],
 "Barter Court"=>["bc", "barter court"],
 "Berkshire"=> ["berkshire", "bk", "bk berkshire apts landmark property services,inc"],
 "Brookview"=> ["brookview", "bv", "bv brookview landmark property services,inc"],
 "Cameron"=> ["cameron", "cb", "cb cameron bldg landmark property services,inc"],
 "Colonial Heights and Township"=> ["colonial heights and township", "ch", "ts", "ch colonial heights, ll landmark property services,inc"],
 "Cloverleaf Lake"=> ["cl", "cloverleaf lake", "cl cloverleaf lake landmark property services,inc"],
 "Creekpointe"=> ["creekpointe", "cp", "cp creekpointe landmark property services,inc"],
 "Glenns at Millers Lane"=> ["glenns at millers lane", "gm", "gm glenns @ miller lane landmark property services,inc"],
 "Hamptons"=>["hamptons", "hm", "hm hamptons landmark property services,inc"],
 "Hickory Point"=> ["hickory point", "hp", "hp hickory point landmark property services,inc"],
 "Hilliard Road"=> ["hilliard road", "hr", "hr hilliard road landmark property services,inc"],
 "Longhill Grove"=> ["longhill grove", "lh", "lh longhill landmark property services,inc"],
 "Lieutenants Run"=> ["lieutenants run", "lr", "lr lieutenant's run landmark property services,inc"],
 "Misty Pines"=> ["misty pints", "ma", "ma misty pines apartmen landmark property services,inc"],
 "Match Point"=> ["match point", "mp", "mp match point landmark property services,inc"],
 "Mayfair"=>["mayfair", "my", "my mayfair landmark property services,inc"],
 "North Dunlop"=>["north dunlop", "nd"],
 "North Slope"=> ["north slope", "ns", "ns north slope landmark property services,inc"],
 "Old Bridge"=> ["old bridge", "ob", "ob old bridge landmark property services,inc"],
 "Overlook at Brook Run"=> ["overlook at brook run", "ol", "om", "ol overlook phase i landmark property services,inc"],
 "Perry Street"=> ["perry street", "ps", "ps perry street landmark property services,inc"],
 "Southgate Manor"=> ["southgate manor", "sf", "sg", "sg southgate manor ph i landmark property services,inc"],
 "Stratford Hills and Bethany Springs"=> ["stratford hills and bethany springs", "sh", "bs","sh stratford hills landmark property services,inc", "bs bethany springs landmark property services,inc"],
 "Sand Ridge"=> ["sand ridge", "sr", "ss", "st", "sr sand ridge phase iii landmark property services,inc"],
 "Tamarack"=> ["tamarack", "tm", "tn", "tm tamarack phase ii landmark property services,inc"],
 "Tanglewood"=> ["tanglewood", "tw", "tx", "tw tanglewood apartment landmark property services,inc"],
 "Willow Oaks"=> ["willow oaks", "wo", "wo willow oaks landmark property services,inc"]
}

property_phases = {
  "Stratford Hills and Bethany Springs" => 2,
  "Sand Ridge" => 3,
  "Tamarack" => 2,
  "Southgate Manor" => 2,
  "Overlook at Brook Run" => 2,
  "Tanglewood" => 2,
  "Colonial Heights and Township" => 2
}

property_total_units = {
  "Arbor Crest" => 70,
  "Barter Court" => 11,
  "Berkshire" => 56,
  "Brookview" => 48,
  "Cameron" => 33,
  "Colonial Heights and Township" => 109,
  "Cloverleaf Lake" => 210,
  "Creekpointe" => 214,
  "Glenns at Millers Lane" => 144,
  "Hamptons" => 212,
  "Hickory Point" => 175,
  "Hilliard Road" => 213,
  "Longhill Grove" => 170,
  "Lieutenants Run" => 168,
  "Misty Pines" => 83,
  "Match Point" => 258,
  "Mayfair" => 197,
  "North Dunlop" => 34,
  "North Slope" => 56,
  "Old Bridge" => 222,
  "Overlook at Brook Run" => 282,
  "Perry Street" => 149,
  "Southgate Manor" => 146,
  "Stratford Hills and Bethany Springs" => 430,
  "Sand Ridge" => 198,
  "Tamarack" => 180,
  "Tanglewood" => 136,
  "Willow Oaks" => 360
}

property_names.each {|key, value|
  p = Property.create!(name: "#{key}")
  value.each {|v|
    AlternateName.create!(name: v, property_id: p.id)
  }
}

property_total_units.each {|key, value|
  p = Property.where(name: key).first
  p.update_attributes(total_units: value)
}

property_phases.each {|key, value|
  p = Property.where(name: key).first
  p.update_attributes(phases: value)
}