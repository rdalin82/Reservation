class ReservationController < ApplicationController
  def index
    @reservations = Reservation.all
  end
end
