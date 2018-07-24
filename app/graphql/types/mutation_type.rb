# frozen_string_literal: true

module Types
  # Top level mutation object that defines all the mutations the app schema provides
  class MutationType < Types::BaseObject
    # Registration and Authentication Operations
    field :register, mutation: Mutations::Register
    field :authenticate, mutation: Mutations::Authenticate

    # Task List Operations
    field :createTaskList , mutation: Mutations::TaskLists::Create
  end
end
