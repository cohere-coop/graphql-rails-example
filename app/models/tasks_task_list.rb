class TasksTaskList < ApplicationRecord
  belongs_to :task_list
  belongs_to :task
end
