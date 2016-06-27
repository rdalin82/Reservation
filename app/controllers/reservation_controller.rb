class ReservationController < ApplicationController
  def index
    @reservations = Reservation.all
  end
  def new
    @seats = (1..20).to_a
    @reservation = Reservation.new
  end
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:success] = ["Your Table has been reserved" ]
      redirect_to root_path
    elsif !@reservation.tables_available?
      flash[:warning] = ["No tables available, only #{@reservation.tables_available}, four seater tables left"] unless @reservation.tables_available?
      redirect_to new_reservation_path
    else 
      flash[:warning] = @reservation.errors.full_messages
      redirect_to new_reservation_path
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservation_index_path
  end

  private 
  def reservation_params 
    params[:reservation][:time] = params[:date][:hour]
    params.require(:reservation).permit(:time, :name, :seats, :date)
  end
end
