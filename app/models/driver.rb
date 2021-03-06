class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, :vin, presence: true

  def driver_total_earnings
    (self.trips.sum { |trip| trip.cost / 100 * 0.8 - 1.65 }.round(2))
  end

  def driver_avg_rating
    if self.trips.length == 0
      return 0
    else
      (self.trips.sum { |trip| trip.rating.to_f } / self.trips.length).round(2)
    end
  end

  def self.available_driver
    all.select { |driver| driver.available == true }.first
  end
end
