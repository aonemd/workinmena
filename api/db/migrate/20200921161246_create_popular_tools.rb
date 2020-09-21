class CreatePopularTools < ActiveRecord::Migration[6.0]
  def change
    create_view :popular_tools, materialized: true

    add_index :popular_tools, :tool_id
  end
end
