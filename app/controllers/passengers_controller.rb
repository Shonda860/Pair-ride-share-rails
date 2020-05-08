class PassengersController < ApplicationController

		def index #list all 
			@passengers = Passenger.all
    end

    def show
    end

    def edit
    end

		def new #render the form for create
			@passenger = Passenger.new
    end

    def create
    end

    def update
    end

    def destroy
		end
		
		private

		def passenger_params
			return params.require(:passenger).permit(:name, :phone_num)
		end

end
