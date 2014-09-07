module AmenitiesHelper

  # Returns the amenities descriptions as a sentence
  #
  # @param [ActiveRecord::Relation <Amenity>] amenities
  #
  # @return [String]
  def amenities_to_sentence(amenities)
    amenities.pluck(:description).to_sentence
  end

end