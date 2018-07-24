module Mutations
  module TaskLists
    class AddUsers < ApplicationMutation
      argument :users, [ID], required: true
      argument :task_lists, [ID], required: true
      payload_type Types::TaskListsAddUserPayload

      def resolve(task_lists:, users:)
        raise AuthenticatedUserRequiredError if guest?
        errors = []
        new_users = User.where(id: users)
        task_lists = current_user.task_lists.where(id: task_lists)
        new_memberships = task_lists.map do |task_list|
          new_users.map do |user|
            membership = task_list.owner_memberships.create(user: user)
            if membership.persisted?
              membership
            else
              errors.push(status: 422, title: "Unable to Add User",
                          detail: membership.errors.full_messages.join("."))
              next
            end
          end
        end.flatten
        { errors: errors, memberships: new_memberships }
      end
    end
  end
end

