class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :call_id
      t.string :call_type
      t.string :address
      t.string :agency
      t.float :latitude
      t.float :longitude
      t.datetime :call_last_updated

      t.timestamps
    end
  end
end