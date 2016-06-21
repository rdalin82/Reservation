class ReservationController < ApplicationController
  def index
    @reservations = Reservation.all
  end
  def new
    @reservation = Reservation.new
  end
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.tables_available? && @reservation.save 
      #make a create table for each table in the seats capacity
      @reservation.save
      @reservation.tables_needed.times do |x| 
        @reservation.tables << Table.create!(time: @reservation.time, size: 4)
      end 
      flash[:success] = ["Your Table has been reserved" ]
      redirect_to root_path
    elsif !@reservation.tables_available?
      flash[:warning] = ["No tables available, only #{@reservation.tables_available}, 4 seater tables left"] unless @reservation.tables_available?
      redirect_to new_reservation_path
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
