class AddZipToCall < ActiveRecord::Migration
  def change
    add_column :calls, :zip, :string
  end
end
