require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  # let (:driver) {
  #   Driver.create name: "driver sample", vin: "VIN99999999", available: true
  # }

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      driver = Driver.create(
        {
          name: "new driver",
          vin: "newvin0000000",
          available: true,
        }
      )
      # Act
      get drivers_path(driver.id)
      # Assert

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver

      # Act

      get driver_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      driver_hash = {
        driver: {
          name: "Charlotte Adams",
          vin: "Adams1232434",
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      # Check that the controller redirected the user

      must_redirect_to driver_path(new_driver)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      driver_hash = {
        driver: {
          name: "Charlotte Adams",
          available: true,
        },
      }
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "edit" do
    before do
      it "responds with success when getting the edit page for an existing, valid driver" do
        # Arrange
        # Ensure there is an existing driver saved
        get edit_driver_path(1)
        # Act

        # Assert
        expect {
          get edit_driver_path(driver.id), params: driver_hash
        }.must_equal driver_hash[:driver][:name]
      end

      it "responds with redirect when getting the edit page for a non-existing driver" do
        # Arrange
        # Ensure there is an invalid id that points to no driver

        # Act
        get edit_driver_path(-1)
        # Assert
        must_respond_with :redirect
        must_redirect_to drivers_path
      end
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do

      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      new_driver = Driver.create(
        {
          name: "new driver",
          vin: "newvin0000000",

        }
      )
      new_driver_hash = {
        driver: {
          name: "Bad driver",
          vin: "newvin0000000",
        },
      }

      updated_driver = Driver.find_by(id: new_driver_hash.id)

      # Set up the form data
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(new_driver.id), params: new_driver_hash
      }.must_differ "Driver.count", 0
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      # find_driver = Driver.last.id

      expect(updated_driver.name).must_equal new_driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal new_driver_hash[:driver][:vin]
      must_redirect_to driver_path(new_driver)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      new_driver_hash =
        {
          driver: {
            name: "Bad driver",
            vin: "newvin0000000",
            available: true,
          },
        }

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller gave back a 404
      expect {
        patch driver_path(-1), params: new_driver_hash
      }.must_differ "Driver.count", 0

      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do

      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end
end

describe "destroy" do
  it "destroys the driver instance in db when driver exists, then redirects" do

    # Arrange
    # Ensure there is an existing driver saved
    driver
    # new_passenger = Passenger.create(
    #   {
    #     name: "new driver",
    #     vin: "newvin0000000",
    #     available: true,
    #   },
    # )
    # trip_1 = Trip.create(driver_id: id, pasenger_id: new_passenger.id, date: Date.today, rating: 5, cost: nil)
    # trip_2 = Trip.create(driver_id: id, pasenger_id: new_passenger.id, date: Datte.today, rating: 1, cost: nil)

    # Act-Assert
    # Ensure that there is a change of -1 in Driver.count
    expect {
      delete driver_path(driver.id)
    }.must_differ "Driver.count", -1
    # Assert
    # Check that the controller redirects
    must_redirect_to drivers_path
  end
  it "does not change the db when the driver does not exist, then responds with " do
    # Arrange
    # Ensure there is an invalid id that points to no driver

    # Act-Assert
    # Ensure that there is no change in Driver.count
    expect {
      delete driver_path(driver[:id])
    }.wont_differ "Driver.count"
    # Assert
    # Check that the controller responds or redirects with whatever your group decides
    must_respond_with :not_found
  end
end
