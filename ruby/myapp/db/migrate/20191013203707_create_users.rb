class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phoneNumber
      t.string :address
      t.string :postalCode
      t.string :local

      t.timestamps
    end
  end
end
