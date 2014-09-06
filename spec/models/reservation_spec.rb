require 'rails_helper'

describe Reservation do

  describe 'validations' do

    let(:reservation_attrs) { attributes_for(:reservation) }

    context 'when the email is empty' do
      before { reservation_attrs[:email] = '' }

      it 'adds an error for email' do
        reservation = Reservation.create(reservation_attrs)

        expect(reservation.errors).to include(:email)
      end
    end

    context 'when the email does not have an @' do
      before { reservation_attrs[:email] = 'not_at_in_here' }

      it 'adds an error for email' do
        reservation = Reservation.create(reservation_attrs)

        expect(reservation.errors).to include(:email)
      end
    end

  end

end
