class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :email, :null => false

      t.timestamps
    end
  end
end
