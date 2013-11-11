class ChangeDefaultsForTomatoes < ActiveRecord::Migration
  def change
    change_column :tomatoes, :plan_time_finished, :integer, :default => 0
    change_column :tomatoes, :work_time_finished, :integer, :default => 0
    change_column :tomatoes, :break_time_finished, :integer, :default => 0
    change_column :tomatoes, :completed, :boolean, :default => false
  end
end
