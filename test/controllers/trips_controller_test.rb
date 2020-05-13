require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create(
      {
        name: "Bobby Brown",
        vin: "11223344",
        available: true,
      }
    )
    @passenger = Passenger.create(
      {
        name: "Lion King",
        phone_num: "xxxxxxxxxx",
      }
    )
    @trip = Trip.create(
      {
        passenger_id: @passenger.id,
        driver_id: @driver.id,
        rating: 3,
        cost: 1600,
        date: Date.today,
      }
    )
  end
  describe "show" do
    # Your tests go here
    it "can get a valid trip" do
      get trip_path(@trip.id)

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new trip" do

      # Act-Assert
      expect {
        post passenger_trip_path(@passenger.id)
      }.must_change "Trip.count", 1

      # new_trip = Trip.find_by(driver_id: trip_hash[:trip][:driver_id])
      # expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_redirect_to trip_path(Trip.last.id)
      new_trip = Trip.find_by(date: Date.today)

      expect(new_trip.passenger.name).must_equal "Lion King"
      expect(new_trip.passenger.id).must_equal @passenger.id
      expect(new_trip.driver.name).must_equal "Bobby Brown"
      expect(new_trip.driver.id).must_equal @driver.id
      expect(new_trip.rating).must_equal 3
    end
  end

  describe "edit" do
    # Your tests go here
    it "can get the edit form for an existing trip" do
      get edit_trip_path(@trip.id)
      must_respond_with :success
    end

    # Your code here
    it "will respond with redirect when attempting to edit a nonexistant trip" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end
  describe "update" do
    it "will update a model with a valid post request" do
      trip_id = Trip.last.id
      new_driver = Driver.create({
        name: "Willy Wonka",
        vin: "56543234",
        available: true,
      })

      new_trip_hash = {
        trip: {
          rating: 5,
          cost: nil,
          driver_id: new_driver.id,
        },
      }

      expect {
        patch trip_path(trip_id), params: new_trip_hash
      }.wont_change "Trip.count"

      must_redirect_to trip_path(trip_id)

      trip = Trip.find_by(id: trip_id)
      expect(trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(trip.rating).must_equal new_trip_hash[:trip][:rating]
    end

    describe "destroy" do
      it "can get destroy" do
        trip_id = Trip.last.id

        expect {
          delete trip_path(trip_id)
        }.must_differ "Trip.count", -1
        must_redirect_to drivers_path
      end
    end

    describe "complete trip" do
      let (:complete_trip) {
        {
          trip: {
            rating: 3,
          },
        }
      }
      it "does not let passenger complete rating  while trip in progress" do
        @trip.update(rating: nil)
        expect { patch complete_trip(@trip.id), params: complete_trip }.wont_differ "Trip.count"
        trip.reload
        expect(@trip.rating).must_equal complete_trip[:trip][:rating]
      end
      it "changes a driver status to available" do
        @trip.driver.update(available: false)

        expect {
          patch complete_trip(@trip.id), params: rate_trip_hash
        }.wont_differ "Trip.count"
      end

      it "a trip is not updated if a trip does not have a valid passenger"

      # expect {
      #   id = -1
      #   patch trip_path(id), params: complete_trip
      # }.wont_differ "Trip.count"

      # must_respond_with :not_found
    end
  end
end
