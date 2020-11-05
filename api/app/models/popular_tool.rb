class PopularTool < ApplicationRecord
  self.primary_key = :tool_id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
