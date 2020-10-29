class Company < ApplicationRecord
  has_many :stack, foreign_key: :company_id, class_name: 'StackEntry', dependent: :destroy
  has_many :tools, through: :stack
  has_one :company_popular_tool, foreign_key: :company_id, class_name: 'CompanyPopularTool', dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, without: /@/

  def popular_tool
    return nil unless company_popular_tool

    Tool.find(company_popular_tool.tool_id)
  end
end
