# frozen_string_literal: true

module Types
  # Top level mutation object that defines all the mutations the app schema provides
  class SubscriptionType < Types::BaseObject

    field :task_added, Types::TaskPayload, null: false do
      argument :task_list, ID, required: true
    end

    def task_added(task_list:)
      context[:current_user].task_lists.find(task_list)
    end
  end
end
