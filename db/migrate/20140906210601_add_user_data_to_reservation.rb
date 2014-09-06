class AddUserDataToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :first_name,    :string
    add_column :reservations, :last_name,     :string
    add_column :reservations, :phone_number,  :integer
    add_column :reservations, :user_ip,       :string
  end
end