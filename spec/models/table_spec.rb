require 'rails_helper'

RSpec.describe Table, type: :model do
  describe "table validations" do 
    let (:empty_table) { Table.new }
    let (:table_with_size) { Table.new(size: 4, date: "2016-06-22", time: 1) }

    it "should not save without a size" do 
      expect(empty_table.save).to eq(false)
    end
    it "should save with size" do 
      expect(table_with_size.save).to eq(true)
    end
  end
end
