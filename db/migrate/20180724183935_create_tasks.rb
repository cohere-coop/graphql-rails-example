class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.timestamps
    end

    create_table :users_tasks do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.timestamps
    end

    create_table :tasks_task_lists do |t|
      t.belongs_to :task
      t.belongs_to :task_list
      t.timestamps
    end
  end
end
