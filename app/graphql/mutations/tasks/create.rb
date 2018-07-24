
module Mutations
  module Tasks
    class Create < ApplicationMutation
      argument :task, Types::TaskInput, required: true
      argument :task_lists, [ID], required: false

      payload_type Types::TaskPayload

      def resolve(task:, task_lists: [])
        raise AuthenticatedUserRequiredError if guest?
        result = current_user.tasks.create(task.to_h)

        current_user.task_lists.where(id: task_lists).each do |task_list|
          task_list.tasks << result
        end

        result
      end
    end
  end
end
