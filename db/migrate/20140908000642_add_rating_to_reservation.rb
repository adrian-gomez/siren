class AddRatingToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :rating, :integer
  end
end