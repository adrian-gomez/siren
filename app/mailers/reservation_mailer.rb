class ReservationMailer < ActionMailer::Base
  default from: CONFIGURATION.mail.sender

  def confirmation_email(reservation)
    @reservation = reservation

    mail(to: reservation.email, subject: t('mailers.reservation.confirm'))
  end

end