require 'rails_helper'

describe 'reservations/rate' do

  let(:reservation) { create(:reservation, :completed) }

  before { assign(:reservation, reservation) }

  it 'renders the reservation information' do
    render

    assert_select '.field', /#{reservation.first_name}/
    assert_select '.field', /#{reservation.last_name}/
    assert_select '.field', /#{reservation.phone_number}/
    assert_select '.field', /#{reservation.housing_date}/
  end

  context 'when the reservation is not rated' do

    before { reservation.rating = nil }

    it 'renders the rate reservation form' do
      render

      assert_select 'form[action=?][method=?]', rating_reservation_path(reservation), :post do
        assert_select 'input[name=?][value=?]', '_method', 'put'
        1.upto(Reservation::MAX_RATING) do |i|
          assert_select "input#reservation_rating_#{i}[name=?][value=?]", 'reservation[rating]', i
        end
        assert_select 'input[type=?]', 'submit'
      end
    end

  end

  context 'when the reservation is rated' do

    before { reservation.rating = 4 }

    it 'renders the reservation rating' do
      render

      assert_select '.field', /#{reservation.rating.to_s}/
    end

  end

end