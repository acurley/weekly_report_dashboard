class Property < ActiveRecord::Base

  attr_accessible :name, :total_units, :phases

  has_many :alternate_names
  has_many :stats

  validates :name, :presence => {
    :message => 'must be provided.'
  }

 
  # def initialize(name, alternate_names)
  #   @name = name
  #   @alternate_names = alternate_names
  #   @total_units = 0
  #   @current_occupied = 0
  #   @total_vacants = 0
  #   @vacant_rented = 0
  #   @vacant_unrented = 0
  #   @phases = 0
  #   @percent_preleased = 0
  #   @total_guest_cards = 0
  #   @total_apps = 0
  # end

end
