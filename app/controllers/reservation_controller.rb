class ReservationController < ApplicationController
  def index
    @reservations = Reservation.all
  end
  def new
    @reservation = Reservation.new
  end
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save && @reservation.tables_available?
      #make a create table for each table in the seats capacity
      @reservation.save
      flash[:success] = ["Your Table has been reserved" ]
      redirect_to root_path
    else 
      flash[:warning] = @reservation.errors.full_messages
      redirect_to new_reservation_path
    end
  end

  private 
  def reservation_params 
    params.require(:reservation).permit(:time, :name, :seats)
  end
end
