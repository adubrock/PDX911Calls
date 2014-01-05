class ChangeLastUpdated < ActiveRecord::Migration
  def change
    change_column :calls, :call_last_updated, :datetime
  end
end
