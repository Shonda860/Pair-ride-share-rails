class PassengersController < ApplicationController

		def index #list all 
			@passengers = Passenger.all
    end

		def show # get one passenger
			# id passed into the route
			id = params[:id]
			@passenger =  Passenger.find_by(id:id)
	
			if @passenger.nil?
				redirect_to passengers_path
				return
			end
		end
  

    def edit
    end

		def new # renders form for create method
			#creates local object but does not validate or save to db
			@passenger = Passenger.new
    end

		def create 
			@passenger = Passenger.create(params[:passenger]) #instantiate new passenger w/strong params
				if @passenger.save 
					redirect_to passengers_path(@passenger.id)
					return
				else
					render :new
					return
				end
    end

    def update
    end

    def destroy
		end
		
		private

		def passenger_params #passenger_id needs to be added here? it's nil in db
			return params.require(:passenger).permit(:name, :phone_num)
		end

end
