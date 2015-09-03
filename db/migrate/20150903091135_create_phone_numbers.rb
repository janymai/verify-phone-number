class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :phone_number
      t.string :pin
      t.boolean :verified
      t.string :email
      t.string :avatar
      t.string :name

      t.timestamps null: false
    end
  end
end
