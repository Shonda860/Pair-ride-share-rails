class PassengersController < ApplicationController

		def index #list all 
			@passengers = Passenger.all
    end

		def show # get one passenger
			id = params[:id] 
			@passenger =  Passenger.find_by(id:id)
	
			if @passenger.nil?
				redirect_to passengers_path
				return
			end
		end
		
		def edit
			id = params[:id] 
			@passenger = Passenger.find_by(id:id)

			if @passenger.nil?
				redirect_to passengers_path
				return
			end
    end

		def new # renders form for create method
			@passenger = Passenger.new
    end

	def create
		passenger = Passenger.new(
		  passenger_params
		)
		if passenger.save
		  redirect_to passengers_path
		  return
		else
		  render :new, :bad_request
		  return
		end
	  end
		

		def update
			id = params[:id]
			@passenger = Passenger.find_by(id:id)
				if @passenger.nil? 
					head :not_found
					return 
				elsif @passenger.update(passenger_params)
					redirect_to passenger_path(@passenger.id) # return to index to view list of passengers
					return
				else #if the save fails
					render :edit  # show the edit form view again
					return
				end
    end

    def destroy
			passenger = Passenger.find_by(id: params[:id]).destroy
			redirect_to passengers_path
			return
		end
		
		private

		def passenger_params
			return params.require(:passenger).permit(:passenger_id, :name, :phone_num)
		end

end
