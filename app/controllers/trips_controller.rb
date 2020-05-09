class TripsController < ApplicationController
  def index # index means list all
    @trips = Trip.all
  end
​
  def show
    @trip = Trip.find_by(id: params[:id].to_i)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end
​
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
​
  def edit
    @trip = Trip.find_by(id: params[:id])
​
    if @trip.nil?
      head :not_found
      return
    end
  end
​
  def destory
    task_id = params[:id]
    @trip = Trip.find_by(id: task_id)
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to trips_path
    end
  end
​
  def new
    @trip = Trip.new
  end
​
  def create
    task = Trip.new(
      trip_params
    )
    if Trip.save
      redirect_to trip_path(trip.id)
      return
    else
      render :new, :bad_request
      return
    end
  end
​
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
​
  # def unmark_complete
  #   @trip = Trip.find_by(id: params[:id])
  #   if @trip.nil?
  #     head :not_found
  #     return
  #   else @trip.update(
  #     status: "not complete",
  #     completed_at: nil,
​
  #   )
  #     redirect_to root_path
  #     return     end
  # end

  private
​
  def trip_params
    return params.require(:task).permit(:name)
  end
 end
