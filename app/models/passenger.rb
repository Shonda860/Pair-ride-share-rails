class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, :phone_num, presence: true

  def total_charges
    (self.trips.sum { |trip| trip.cost } / 100)
  end
end
