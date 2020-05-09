class Passenger < ApplicationRecord
    has_many :trips
    # these two lines can go on the same line? 
    validates :name, :phone_num, presence: true

  

end
