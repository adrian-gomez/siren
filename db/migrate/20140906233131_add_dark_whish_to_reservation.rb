class AddDarkWhishToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :dark_wish, :string
  end
end
