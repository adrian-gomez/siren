class Amenity < ActiveRecord::Base

  has_and_belongs_to_many :reservations

end