# frozen_string_literal: true

module Types
  # Top level mutation object that defines all the mutations the app schema provides
  class SubscriptionType < Types::BaseObject

    field :task_added, Types::Task, null: false do
      argument :task_list, ID, required: true
    end
  end
end
