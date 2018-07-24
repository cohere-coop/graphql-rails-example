class Task < ApplicationRecord
  has_many :users_tasks
  has_many :users, through: :users_tasks

  has_many :tasks_task_lists
  has_many :task_lists, through: :tasks_task_lists
end
