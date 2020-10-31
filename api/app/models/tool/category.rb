class Tool::Category < ApplicationRecord
  has_many :tools, foreign_key: :tool_category_id

  validates_presence_of :name
  validates_uniqueness_of :name
end
