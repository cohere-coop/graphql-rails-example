class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: true

      t.timestamps
    end
    create_table :identities do |t|
      t.belongs_to :user, foreign_key: true
      t.string :identifier, null: false
      t.string :password_digest, null: true
      t.string :type, default: "Identity"
    end
  end
end
