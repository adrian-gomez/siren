class AddHousingDateToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :housing_date, :date
  end
end
