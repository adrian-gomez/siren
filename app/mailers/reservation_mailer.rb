class ReservationMailer < ActionMailer::Base
  add_template_helper(AmenitiesHelper)
  add_template_helper(DateHelper)

  default from: CONFIGURATION.mail.sender

  def confirmation_email(reservation)
    @reservation = reservation

    mail(to: reservation.email, subject: t('mailers.reservation.confirm'))
  end

  def completed_email(reservation)
    @reservation = reservation

    mail(to: reservation.email, subject: t('mailers.reservation.completed'))
  end

  def scheduled_email(reservation)
    @reservation = reservation

    mail(to: CONFIGURATION.mail.reservation_scheduled.receiver,
         subject: t('mailers.reservation.scheduled'))
  end
end