class CreateVcards < ActiveRecord::Migration
  def self.up
    create_table :vcards do |t|
      t.string :location
      t.string :street
      t.string :locality
      t.string :region
      t.string :postalcode
      t.string :country
      t.string :first_name
      t.string :last_name
      t.string :org
      t.string :email1
      t.string :email1_type
      t.string :email2
      t.string :email2_type
      t.string :work_phone
      t.string :home_phone
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :vcards
  end
end
