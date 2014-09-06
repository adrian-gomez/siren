class ReservationsController < ApplicationController

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(create_reservation_params)

    if @reservation.save
      ReservationMailer.confirmation_email(@reservation).deliver
      redirect_to new_reservation_path, notice: t('reservation.created')
    else
      render :new
    end
  end

  # GET /reservations/:id/confirm
  def confirm

  end

  private

  def create_reservation_params
    params.require(:reservation).permit(:email)
  end

end