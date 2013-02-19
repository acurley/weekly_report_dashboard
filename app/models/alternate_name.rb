class AlternateName < ActiveRecord::Base
  attr_accessible :name, :property_id

  belongs_to :property
end
