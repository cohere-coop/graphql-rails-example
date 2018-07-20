module Types
  class PayloadObject < BaseObject
    field :errors, [Error], null: true

    def errors
      object.errors if object.respond_to?(:errors)
    end
  end
end
