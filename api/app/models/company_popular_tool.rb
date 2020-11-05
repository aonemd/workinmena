class CompanyPopularTool < ApplicationRecord
  self.primary_key = :company_id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
