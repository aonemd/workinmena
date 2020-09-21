class CreateCompanyPopularTools < ActiveRecord::Migration[6.0]
  def change
    create_view :company_popular_tools, materialized: true

    add_index :company_popular_tools, :company_id
  end
end
