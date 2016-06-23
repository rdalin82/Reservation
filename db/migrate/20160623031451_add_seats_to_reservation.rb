class AddSeatsToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :seats, :integer
  end
end
