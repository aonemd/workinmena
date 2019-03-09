class Stack < ApplicationRecord
  belongs_to :company
  belongs_to :tool

  validates_uniqueness_of :company_id, scope: :tool_id, message: "Tool alreaded added to company's stack"
end
