module Mutations
  module TaskLists
    class Create < ApplicationMutation
      argument :task_list, Types::TaskListInput, required: true
      payload_type Types::TaskListPayload

      def resolve(task_list:)
        raise AuthenticatedUserRequiredError if guest?
        task_list = TaskList.create(task_list.to_h)
        task_list.owner_memberships.create(user: current_user)
        task_list
      end
    end
  end
end

