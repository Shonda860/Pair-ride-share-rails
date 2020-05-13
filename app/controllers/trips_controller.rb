class TripsController < ApplicationController
  def index
  end

  def show # may need a redirect for index
    @trip = Trip.find_by(id: params[:id].to_i)
    if @trip.nil?
      redirect_to trips_path
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
      redirect_to trip_path
      return
    else
      render :edit
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
      redirect_to trips_path
    end
  end

  # def new
  #   @trip = Trip.new
  # end

  def passenger_trips
    driver = Driver.aviable_driver
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
        redirect_to trip_path(trip.id)
        return
      else
        render :new, status: :bad_request
        return
      end
    end
  end

  # def mark_complete
  #   @trip = Trip.find_by(id: params[:id])
  #   if @trip.nil?
  #     head :not_found
  #     return
  #   else @trip.update(
  #     status: "completed",
  #     completed_at: Time.now,
  #   )
  #     redirect_to root_path
  #     return     end
  # end

  # def unmark_complete
  #   @trip = Trip.find_by(id: params[:id])
  #   if @trip.nil?
  #     head :not_found
  #     return
  #   else @trip.update(
  #     status: "not complete",
  #     completed_at: nil,

  #   )
  #     redirect_to root_path
  #     return     end
  # end

  private

  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id)
  end
end
