class ReservationsController < ApplicationController

  before_action :set_reservation, only: [:confirm, :confirmation, :customize, :customization]

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

  # PUT /reservations/:id/confirmation
  def confirmation
    if @reservation.update(confirm_reservation_params)
      redirect_to customize_reservation_path(@reservation), notice: t('reservation.confirmed')
    else
      render :confirm
    end
  end

  # GET /reservations/:id/customize
  def customize

  end
  # PUT /reservations/:id/customization
  def customization
    @reservation.update(customize_reservation_params)
    ReservationMailer.completed_email(@reservation).deliver
    ReservationMailer.scheduled_email(@reservation).deliver

    redirect_to new_reservation_path, notice: t('reservation.completed')
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def create_reservation_params
    params.require(:reservation).permit(:email)
  end

  def confirm_reservation_params
    params.require(:reservation).permit(:first_name, :last_name,
                                        :phone_number).merge(user_ip: request.remote_ip)
  end

  def customize_reservation_params
    params.require(:reservation).permit(:housing_date, :dark_wish, :amenity_ids => [])
  end

end