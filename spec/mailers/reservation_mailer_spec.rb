require "rails_helper"

describe ReservationMailer do

  describe '#confirmation_email' do

    let(:reservation) { create(:reservation) }

    subject(:mail) { ReservationMailer.confirmation_email(reservation) }

    it 'is from the correct address' do
      expect(mail.from).to include(CONFIGURATION.mail.sender)
    end

    it 'goes to the address in the reservation' do
      expect(mail.to).to include(reservation.email)
    end

    it 'uses the correct subject' do
      expect(mail.subject).to eq(I18n.t('mailers.reservation.confirm'))
    end

    it 'renders the confirmation link for the reservation' do
      expect(mail.body).to include(confirm_reservation_path(reservation))
    end

  end

end