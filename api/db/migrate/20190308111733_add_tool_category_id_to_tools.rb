class AddToolCategoryIdToTools < ActiveRecord::Migration[6.0]
  def change
    add_reference :tools, :tool_category, foreign_key: true
  end
end
