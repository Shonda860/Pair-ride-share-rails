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
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
