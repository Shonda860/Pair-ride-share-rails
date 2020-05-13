class TripsController < ApplicationController
  def index
  end

  def show # may need a redirect for index
    @trip = Trip.find_by(id: params[:id].to_i)
    if @trip.nil?
      redirect_to trip_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(
      trip_params
    )
      redirect_to trip_path(@trip.id)

      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to root_path
    end
  end

  # def new
  #   @trip = Trip.new
  # end

  def passenger_trip
    driver = Driver.available_driver
    if !driver.nil?
      @trip = Trip.new(
        date: Date.today,
        rating: nil,
        cost: 100,
        passenger_id: params[:passenger_id],
        driver_id: driver.id,
      )
      if @trip.save
        trip_driver = Driver.find_by(id: @trip.driver_id)
        trip_driver.update(available: false)
        redirect_to trip_path(@trip.id)
        return
      else
        redirect_to passenger_path(params[:passenger_id])
        return
      end
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id, :cost, :rating, :date)
  end
end
