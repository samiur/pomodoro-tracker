class AddTomatoRefToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :tomato, index: true
  end
end
