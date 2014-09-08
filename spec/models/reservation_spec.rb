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

    context 'when updating' do

      let(:reservation) { create(:reservation) }

      let(:new_attributes) { { first_name: 'Coyote', last_name: 'Acme', phone_number: '1234567890'} }

      context 'when a new email is given' do
        before { new_attributes[:email] = 'new@email.com' }

        it 'adds an error for email' do
          reservation.update(new_attributes)

          expect(reservation.errors).to include(:email)
        end
      end

      context 'when the first_name is empty' do
        before { new_attributes[:first_name] = '' }

        it 'adds an error for first_name' do
          reservation.update(new_attributes)

          expect(reservation.errors).to include(:first_name)
        end
      end

      context 'when the last_name is empty' do
        before { new_attributes[:last_name] = '' }

        it 'adds an error for last_name' do
          reservation.update(new_attributes)

          expect(reservation.errors).to include(:last_name)
        end
      end

      context 'when the phone_number is empty' do
        before { new_attributes[:phone_number] = '' }

        it 'adds an error for phone_number' do
          reservation.update(new_attributes)

          expect(reservation.errors).to include(:phone_number)
        end
      end

      context 'when the phone_number is not a number' do
        before { new_attributes[:phone_number] = 'not_a_number' }

        it 'adds an error for phone_number' do
          reservation.update(new_attributes)

          expect(reservation.errors).to include(:phone_number)
        end
      end

      context 'when updating the rating' do
        context 'when rating is not a number' do
          before { new_attributes[:rating] = 'a' }

          it 'adds an error for rating' do
            reservation.attributes = new_attributes
            reservation.valid?(:rate)

            expect(reservation.errors).to include(:rating)
          end
        end

        context 'when rating is less than 1' do
          before { new_attributes[:rating] = 0 }

          it 'adds an error for rating' do
            reservation.attributes = new_attributes
            reservation.valid?(:rate)

            expect(reservation.errors).to include(:rating)
          end
        end

        context 'when rating is more than Reservation::MAX_RATING' do
          before { new_attributes[:rating] = Reservation::MAX_RATING  + 1 }

          it 'adds an error for rating' do
            reservation.attributes = new_attributes
            reservation.valid?(:rate)

            expect(reservation.errors).to include(:rating)
          end
        end
      end

      context 'when the reservation has been rated' do
        let(:reservation) { create(:reservation, :rated) }

        context 'when a new rating is given' do
          before { new_attributes[:rating] = 1 }

          it 'adds an error for rating' do
            reservation.update(new_attributes)

            expect(reservation.errors).to include(:rating)
          end
        end
      end
    end

  end

end
