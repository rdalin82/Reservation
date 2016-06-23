class AddDateToReservationAndTables < ActiveRecord::Migration
  def change
    add_column :reservations, :date, :datetime
    add_column :tables, :date, :datetime
  end
end
