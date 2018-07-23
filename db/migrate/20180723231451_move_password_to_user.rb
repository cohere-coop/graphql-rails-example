class MovePasswordToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :password_digest, :string, null: true
    execute <<~SQL
      UPDATE users SET password_digest = (SELECT password_digest
                                          FROM identities
                                          WHERE user_id == users.id AND identities.password_digest NOT NULL)
    SQL
    execute <<~SQL
      UPDATE identities SET type="EmailIdentity" WHERE type="EmailAndPasswordIdentity"

    SQL
    remove_column :identities, :password_digest
  end

  def down
    add_column :identities, :password_digest, :string, null: true
    execute <<~SQL
      UPDATE identities SET type="EmailAndPasswordIdentity",
                            password_digest=(SELECT password_digest
                                             FROM users
                                             WHERE user_id == users.id) WHERE type="EmailIdentity"
    SQL
    remove_column :users, :password_digest
  end
end
