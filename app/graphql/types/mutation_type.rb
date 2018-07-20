# frozen_string_literal: true

module Types
  # Top level mutation object that defines all the mutations the app schema provides
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :authenticate, mutation: Mutations::Authenticate
  end
end
