class TomatoSerializer < ActiveModel::Serializer
  attributes :plan_time, :work_time, :break_time, :completed

  has_many :tasks
end
