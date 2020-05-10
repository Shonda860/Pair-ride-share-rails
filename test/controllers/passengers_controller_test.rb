require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample passenger", phone_num: "555-555-5555"
  }
  describe "index" do
    it "can get index" do

      # Act

      get passengers_path

      # Assert

      must_respond_with :success
    end

    # need a test for it "can get root"
  end

  describe "show" do
    it "can get a valid passenger" do
      
      # Act

      get passengers_path(passenger.id)
      
      # Assert

      must_respond_with :success
    end
    
    it "will redirect for an invalid passenger" do
      
      # Act

      get passenger_path(-1)
      
      # Assert

      must_respond_with :redirect
    end
  end

  describe "new" do
    # Your tests go here
    it "can get the new passenger form page" do

      get new_passenger_path

      must_respond_with :success
    end

    
  end

  describe "create" do
    # Your tests go here
    it "can create a new passenger" do

      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_num: "123-456-7890",
        },
      }

      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
          }.must_change "Passenger.count", 1
      
          new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
          expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
   
  end

  describe "edit" do
    # Your tests go here
    it "can get the edit form for an existing passenger" do

      get edit_passenger_path(1)
    end

      # Your code here
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
  
      get edit_passenger_path(-1)
  
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
