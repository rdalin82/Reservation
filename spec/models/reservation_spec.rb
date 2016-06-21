require 'rails_helper'
require "#{Rails.root}/config/table_config"

RSpec.describe Reservation, type: :model do
  describe "validations" do 
    let(:empty_reservation) { Reservation.new }
    let(:valid_reservation) { Reservation.new(time: 1, name: "Carlson", seats: 4) }
    let(:reservation) {Reservation.create(time: 1, name: "Jefferson", seats: 4) }
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
      expected_count = TableCount.four_seater - Table.where(time: reservation.time).count - reservation.tables_needed
      expect(reservation.tables_available).to eq(expected_count)
    end
  end
end
