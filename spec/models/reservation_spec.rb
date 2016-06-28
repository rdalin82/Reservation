require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "validations" do 
    let(:empty_reservation) { Reservation.new }
    let(:zero_reservation) { Reservation.new(time: 1, name: "Carlson", seats: 0, date: DateTime.now + 3.months) }
    let(:valid_reservation) { Reservation.new(time: 1, name: "Carlson", seats: 4, date: DateTime.now + 3.months) }
    let(:reservation) {Reservation.create(time: 1, name: "Jefferson", seats: 4, date: DateTime.now + 3.months) }
    let(:reservation12) {Reservation.create(time: 1, name: "Jefferson", seats: 12, date: DateTime.now + 3.months) }
    let(:reservation11) {Reservation.create(time: 1, name: "Jefferson", seats: 11, date: DateTime.now + 3.months) }
    let(:reservation5) {Reservation.create(time: 1, name: "Jefferson", seats: 5, date: DateTime.now + 3.months) }

    it "should not save an empty reservation" do 
      expect(empty_reservation.save).to eq(false) 
    end
    it "should save valid reservation" do 
      expect(valid_reservation.save).to eq(true) 
    end
    it "tables_needed" do
      expect(reservation.tables_needed).to eq(1)
    end 
    it "should have a method tables_available" do
      #Total 4 seat tables - Tables at that time - (this request)full 4 seaters - partial 4 seaters
      expected_count = TableCount.four_seater - Table.where(time: reservation.time).count
      expect(reservation.tables_available).to eq(expected_count)
    end
    it "should not validate a reservation with zero tables" do 
      expect(zero_reservation.save).to eq(false)
    end
    it "should have 3 tables for 12 seats" do 
      expect(reservation12.tables_needed).to eq(3)
    end
    it "should have 2 tables for 5 seats" do 
      expect(reservation5.tables_needed).to eq(2)
    end
    it "should have 3 tables for 11 seats" do 
      expect(reservation11.tables_needed).to eq(3)
    end
  end
end
