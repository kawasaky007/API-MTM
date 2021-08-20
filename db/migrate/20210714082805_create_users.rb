class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :phone_number
      t.string :full_name
      t.string :sex
      t.string :password_digest
      t.string :email
      t.string :address_city
      t.string :address_district
      t.string :address_ward
      t.string :address_details
      t.datetime :dob

      t.timestamps
    end
  end
end
