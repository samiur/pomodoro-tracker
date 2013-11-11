class Tomato < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  before_save :fill_completed_field

  accepts_nested_attributes_for :tasks

  def fill_completed_field
    if plan_time_finished == plan_time &&
        work_time_finished == work_time &&
        break_time_finished == break_time
      self.completed = true
    end
  end
end
