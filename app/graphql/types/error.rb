module Types
  class Error < BaseObject
    field :title, String, null: true
    field :detail, String, null: true
    field :status, String, null: true
  end
end
