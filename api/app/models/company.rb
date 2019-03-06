class Company < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, without: /@/
end
