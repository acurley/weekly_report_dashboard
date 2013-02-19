class Stat < ActiveRecord::Base
  attr_accessible :date_retrieved, :current_occupied, :total_vacants, :vacant_rented, :vacant_unrented, 
                  :percent_occupied, :percent_preleased, :phases, :total_guest_cards, :total_apps, :application_accepted,
                  :application_accepted_with_conditions, :applications_declined, :average_application_score, :rejection_rate

  belongs_to :property

  validates :date_retrieved, :presence => {
    :message => 'must be provided.'
  }

end
