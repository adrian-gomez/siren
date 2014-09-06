class CreateAmenitiesReservations < ActiveRecord::Migration
  def change
    create_table :amenities_reservations do |t|
      t.belongs_to :amenity
      t.belongs_to :reservation
    end
  end
end
