require 'rails_helper'

describe 'reservations/confirm' do

  let(:reservation) { create(:reservation) }

  before { assign(:reservation, reservation) }

  it 'renders the confirm reservation form' do
    render

    assert_select 'form[action=?][method=?]', confirmation_reservation_path(reservation), :post do
      assert_select 'input[name=?][value=?]', '_method', 'put'
      assert_select 'input#reservation_first_name[name=?]', 'reservation[first_name]'
      assert_select 'input#reservation_last_name[name=?]', 'reservation[last_name]'
      assert_select 'input#reservation_phone_number[name=?]', 'reservation[phone_number]'
      assert_select 'input[type=?]', 'submit'
    end
  end
end