class AddStreetAddressToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :street_address, :string
  end
end
