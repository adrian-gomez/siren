require 'rails_helper'

describe 'reservations/new' do
  before do
    assign(:reservation, build(:reservation))
  end

  it 'renders new reservation form' do
    render

    assert_select 'form[action=?][method=?]', reservations_path, :post do
      assert_select 'input#reservation_email[name=?]', 'reservation[email]'
      assert_select 'input[type=?]', 'submit'
    end
  end
end