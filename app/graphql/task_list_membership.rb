class TaskListMembership < ApplicationRecord
  belongs_to :user
  belongs_to :task_list

  scope :owners, -> { where(role: :owner) }
end
