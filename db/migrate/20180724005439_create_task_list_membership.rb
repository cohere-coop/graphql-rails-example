class CreateTaskListMembership < ActiveRecord::Migration[5.2]
  def change
    create_table :task_lists do |t|
      t.string :name
      t.timestamps
    end

    create_table :task_list_memberships do |t|
      t.references :task_list, null: false
      t.references :user, null: false
      t.string :role, null: false, default: :member
      t.timestamps
    end
  end
end
