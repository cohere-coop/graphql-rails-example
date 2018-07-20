# frozen_string_literal: true

module Types
  class Identity < BaseObject
    field :id, ID, null: false
    field :identifier, String, null: true
    field :type, String, null: true
  end
end
