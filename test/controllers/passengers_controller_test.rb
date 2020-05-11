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
    it "will update a model with a valid post request" do

      new_passenger = Passenger.create(name: "Rails Testing", phone_num: "098-765-4321")
      new_passenger_hash = {
        passenger: {
          name: "Rails Testing",
          phone_num: "098-",
          
        }
      }    
    # Note:  If there was a way to fail to save the changes to a passenger, that would be a great
    #        thing to test.
      expect {
        patch passenger_path(new_passenger.id), params: new_passenger_hash
      }.wont_change 'Passenger.count'

      must_redirect_to passenger_path(new_passenger.id)

      passenger = Passenger.find_by(id: new_passenger.id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
    end

    # it "will respond with not_found for invalid ids" do
    #   id = -1
  
    #   expect {
    #     patch passenger_path(id), params: new_passenger_hash
    #   }.wont_change "Passenger.count"
  
    #   must_respond_with :not_found
    # end
  
    # it "will not update if the params are invalid" do
    #   # this test has not yet be covered
    # end
  end

  describe "destroy" do
    it "can get destroy" do

      get delete_passenger_path(passenger.id)

      must_respond_with :success
    end

   

  end


end
