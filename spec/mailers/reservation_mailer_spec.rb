require 'rails_helper'

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

  describe '#completed_email' do

    let(:reservation) { create(:reservation, :completed) }

    subject(:mail) { ReservationMailer.completed_email(reservation) }

    it 'is from the correct address' do
      expect(mail.from).to include(CONFIGURATION.mail.sender)
    end

    it 'goes to the address in the reservation' do
      expect(mail.to).to include(reservation.email)
    end

    it 'uses the correct subject' do
      expect(mail.subject).to eq(I18n.t('mailers.reservation.completed'))
    end

    describe 'its body' do

      subject { mail.body }

      it { is_expected.to include(reservation.first_name) }
      it { is_expected.to include(reservation.last_name) }
      it { is_expected.to include(reservation.phone_number) }
      it { is_expected.to include(reservation.housing_date) }

    end

  end

  describe '#scheduled_email' do

    let(:reservation) { create(:reservation, :completed) }
    let(:amenity) { create(:amenity) }

    subject(:mail) { ReservationMailer.scheduled_email(reservation) }

    before { reservation.amenities << amenity }

    it 'is from the correct address' do
      expect(mail.from).to include(CONFIGURATION.mail.sender)
    end

    it 'goes to the expected address' do
      expect(mail.to).to include(CONFIGURATION.mail.reservation_scheduled.receiver)
    end

    it 'uses the correct subject' do
      expect(mail.subject).to eq(I18n.t('mailers.reservation.scheduled'))
    end

    describe 'its body' do

      subject { mail.body }

      it { is_expected.to include(reservation.first_name) }
      it { is_expected.to include(reservation.last_name) }
      it { is_expected.to include(reservation.phone_number) }
      it { is_expected.to include(reservation.user_ip) }
      it { is_expected.to include(reservation.housing_date) }
      it { is_expected.to include(reservation.dark_wish) }
      it { is_expected.to include(amenity.description) }
    end

  end

end