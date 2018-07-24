class TaskList < ApplicationRecord
  has_many :memberships, class_name: :task_list_memberships
  has_many :members, through: :memberships, class_name: :User
  has_many :owner_memberships, -> { owners }, class_name: :TaskListMembership
  has_many :owners, through: :owner_memberships, source: :user

  has_many :tasks_task_lists
  has_many :tasks, through: :tasks_task_lists
end
