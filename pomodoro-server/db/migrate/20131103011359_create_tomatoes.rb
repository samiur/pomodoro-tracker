class CreateTomatoes < ActiveRecord::Migration
  def change
    create_table :tomatoes do |t|
      t.integer :plan_time
      t.integer :work_time
      t.integer :break_time
      t.integer :plan_time_finished
      t.integer :work_time_finished
      t.integer :break_time_finished
      t.boolean :completed
      t.references :user, index: true

      t.timestamps
    end
  end
end
