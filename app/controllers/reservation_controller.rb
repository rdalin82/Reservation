class ReservationController < ApplicationController
  def index
    @reservations = Reservation.all
  end
  def new
    @times = available_time
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
      render 'new'
    end
  end

  private 
  def reservation_params 
    params.require(:reservation).permit(:time, :name, :seats)
  end
  def available_time
    time = []
    ["am", "pm"].each do |x|
      (1..12).each do |y|
        time << "#{y}:00#{x}"
      end
    end
    time
  end

end
