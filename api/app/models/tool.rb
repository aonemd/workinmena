class Tool < ApplicationRecord
  belongs_to :category, foreign_key: :tool_category_id, class_name: 'Tool::Category'

  validates_presence_of :name
  validates_uniqueness_of :name
end
