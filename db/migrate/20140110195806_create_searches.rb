class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :address
      t.string :zip
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
