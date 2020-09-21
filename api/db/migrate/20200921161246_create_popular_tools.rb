class CreatePopularTools < ActiveRecord::Migration[6.0]
  def change
    create_view :popular_tools, materialized: true
  end
end
