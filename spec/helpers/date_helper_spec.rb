require 'rails_helper'

describe DateHelper do

  describe '#safe_l' do

    context 'when date is nil' do
      it 'returns not available' do
        expect(helper.safe_l(nil)).to eq(t('application.not_available'))
      end
    end

    context 'when date is given' do
      let(:date) { Date.today }

      it 'localizes the date' do
        expect(helper.safe_l(date)).to eq(l(date))
      end
    end

  end

end