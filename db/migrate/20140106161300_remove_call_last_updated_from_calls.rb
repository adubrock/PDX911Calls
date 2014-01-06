class RemoveCallLastUpdatedFromCalls < ActiveRecord::Migration
  def change
    remove_column :calls, :updated_at, :datetime
    rename_column :calls, :call_last_updated, :updated_at
  end
end
