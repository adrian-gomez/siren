require 'rails_helper'

describe AmenitiesHelper do

  describe '#amenities_to_sentence' do

    it 'returns the amenities descriptions as a sentence' do
      amenity = create(:amenity)
      other_amenity = create(:amenity)

      expected = "#{amenity.description} and #{other_amenity.description}"
      expect(helper.amenities_to_sentence(Amenity.all)).to eq(expected)
    end

  end

end