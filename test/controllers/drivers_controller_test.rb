require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  before do
    @driver = Driver.create(
      {
        name: "Bobby Brown",
        vin: "11223344",
        available: true,
      },
    )
  end

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

      # Act
      get drivers_path(@driver.id)
      # Assert

      must_respond_with :success
    end

    it "responds with redirect with an invalid driver id" do
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
          name: "AMe",
          vin: "4342242424",
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

      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      new_driver = Driver.create(name: "Driver", vin: "55343434")

      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count
      driver_hash = {
        driver: {
          name: "",
          vin: "4342242424",
        },
      }

      # Assert
      # Check that the controller redirects
      expect {
        patch driver_path(new_driver.id), params: driver_hash
      }.must_differ "Driver.count", 0
      must_respond_with :bad_request
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
          get edit_driver_path(@driver.id), params: driver_hash
        }.must_equal @driver.id[:driver][:name]
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
    before do
      driver = Driver.create(
        name: "Bobby Brown",
        vin: "11223344",
        available: true,
      )
    end
    let(:driver_hash) {
      {
        driver: {
          name: "Bad driver",
          vin: "newvin0000000",
        },
      }
    }

    it "can update an existing driver with valid information accurately, and redirect" do

      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable

      # Set up the form data
      # Act-Assert
      # Ensure that there is no change in Driver.count
      a_driver = Driver.first
      expect {
        patch driver_path(a_driver.id), params: driver_hash
      }.wont_change "Driver.count"
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      # find_driver = Driver.last.id
      must_respond_with :redirect
      must_redirect_to driver_path(a_driver.id)
      a_driver.reload

      expect(a_driver.name).must_equal driver_hash[:driver][:name]
      expect(a_driver.vin).must_equal driver_hash[:driver][:vin]
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      id = -1
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
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"

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

# describe "destroy" do
#   it "destroys the driver instance in db when driver exists, then redirects" do
#     before do
#       Driver.create(
#         name: "new driver",
#         vin: "newvin0000000",
#         available: true,
#       )
#     end
#     # Arrange
#     # Ensure there is an existing driver saved

#     a_driver = Driver.first

#     # Act-Assert
#     # Ensure that there is a change of -1 in Driver.count
#     expect {
#       delete driver_path(a_driver.id)
#     }.must_change "Driver.count", -1
#     # Assert
#     # Check that the controller redirects
#     must_respond_with :redirect
#     must_redirect_to drivers_path
#   end
#   it "does not change the db when the driver does not exist, then responds with " do
#     # Arrange
#     # Ensure there is an invalid id that points to no driver

#     # Act-Assert
#     # Ensure that there is no change in Driver.count
#     expect {
#       delete driver_path(-1)
#     }.wont_differ "Driver.count"
#     # Assert
#     # Check that the controller responds or redirects with whatever your group decides
#     must_respond_with :not_found
# end
# end
# end
