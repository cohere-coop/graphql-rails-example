# frozen_string_literal: true

# A User who has registered for the service
class User < ApplicationRecord
  has_many :identities
  has_many :access_token_identities, class_name: :AccessTokenIdentity
  has_many :email_identities, class_name: :EmailIdentity

  has_many :task_list_memberships
  has_many :task_lists, through: :task_list_memberships

  has_many :users_tasks
  has_many :tasks, through: :users_tasks

  has_secure_password

  def access_token
    access_token_identities&.first&.identifier
  end

  def email
    email_identities&.first&.identifier
  end
end
