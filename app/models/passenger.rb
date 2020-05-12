class Passenger < ApplicationRecord
  has_many :trips
  validates :name, :phone_num, presence: true

  def total_charges
    (self.trips.sum { |trip| trip.cost } / 100)
  end
end