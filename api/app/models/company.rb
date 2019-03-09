class Company < ApplicationRecord
  has_many :stack, foreign_key: :company_id, class_name: 'Stack'
  has_many :tools, through: :stacks

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, without: /@/
end
