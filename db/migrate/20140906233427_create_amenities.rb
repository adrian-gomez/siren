class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :description
    end
  end
end
