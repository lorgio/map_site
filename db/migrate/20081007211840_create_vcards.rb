class CreateVcards < ActiveRecord::Migration
  def self.up
    create_table :vcards do |t|
      t.string :location
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :first_name
      t.string :last_name
      t.string :org
      t.string :work_email
      t.string :home_email
      t.string :work_phone
      t.string :home_phone
      t.string :url
      t.float :lat
      t.float :lng      
      t.float :distance
      t.timestamps
    end
  end

  def self.down
    drop_table :vcards
  end
end
