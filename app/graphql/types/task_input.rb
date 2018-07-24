module Types
  class TaskInput < BaseInputObject
    argument :title, String, required: false
    argument :description, String, required: false
  end
end

