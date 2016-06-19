require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "validations" do 
    let(:empty_reservation) { Reservation.new }
    let(:valid_reservation) { Reservation.new(time: 1, name: "Carlson", seats: 4) }
    it "should not save an empty reservation" do 
      expect(empty_reservation.save).to eq(false) 
    end
    it "should save valid reservation" do 
      expect(valid_reservation.save).to eq(true) 
    end

  end
end
