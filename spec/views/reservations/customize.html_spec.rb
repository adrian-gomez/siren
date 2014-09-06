require 'rails_helper'

describe 'reservations/customize' do

  let(:reservation) { create(:reservation) }

  before do
    assign(:reservation, reservation)
    3.times { create(:amenity) }
  end

  it 'renders the customize reservation form' do
    render

    assert_select 'form[action=?][method=?]', customization_reservation_path(reservation), :post do
      assert_select 'input[name=?][value=?]', '_method', 'put'
      assert_select 'select#reservation_housing_date_1i[name=?]', 'reservation[housing_date(1i)]'
      assert_select 'select#reservation_housing_date_2i[name=?]', 'reservation[housing_date(2i)]'
      assert_select 'select#reservation_housing_date_3i[name=?]', 'reservation[housing_date(3i)]'
      assert_select 'textarea#reservation_dark_wish[name=?]', 'reservation[dark_wish]'
      Amenity.all.each do |amenity|
        assert_select 'input[type=?][name=?][value=?]', :checkbox, 'reservation[amenity_ids][]',
                                                        amenity.id
      end
      assert_select 'input[type=?]', 'submit'
    end
  end
end