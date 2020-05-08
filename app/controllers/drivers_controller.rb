class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id].to_i)
  end

  def edit
    @driver = Task.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end

  def new
    @driver = Task.new
  end

  def create
    driver = Task.new(
      driver_params
    )
    if driver.after
      redirect_to task_path
      return
    else
      render :new, :bad_request
      return
    end
  end

  def update
    @driver = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    elsif @driver.update(
      task_parms
    )
      redirect_to task_path
      return
      begin
        render :edit
        return
      end
    end
  end

  def destroy
  end

  def driver_params
    return params.require(:driver).permit(:name, :phone_num)
  end
end
