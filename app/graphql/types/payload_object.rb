module Types
  class PayloadObject < BaseObject
    field :errors, [Error], null: true

    def errors
      return object[:errors] if object.respond_to?(:key?) && object[:errors]
      return nil unless object.respond_to?(:errors)
      object.errors.map do |field, message|
        if field == :credentials
          { status: 401, title: "Invalid Credentials", field: field, detail: message }
        else
          { status: 422, title: "Validation Error", field: field, detail: "#{message}" }
        end
      end
    end
  end
end
